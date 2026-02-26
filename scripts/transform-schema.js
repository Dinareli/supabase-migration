const fs = require('fs');
const path = require('path');

const BUBBLE_DIR = path.join(__dirname, '..', 'bubble');
const USER_TYPES_PATH = path.join(BUBBLE_DIR, 'user_types.json');
const OPTION_SETS_PATH = path.join(BUBBLE_DIR, 'option_sets.json');
const OUTPUT_PATH = path.join(__dirname, '..', 'output', 'bubble-schema.md');

const PRIMITIVES = new Set([
  'text', 'number', 'boolean', 'date', 'image', 'file',
  'date_range', 'dateinterval', 'geographic_address',
]);

// --- Lookup maps ---

function buildTableMap(userTypes) {
  const map = {};
  for (const [key, table] of Object.entries(userTypes)) {
    map[key] = table['%d'];
  }
  return map;
}

function buildOptionSetMap(optionSets) {
  const map = {};
  for (const [key, os] of Object.entries(optionSets)) {
    map[key] = os['%d'];
  }
  return map;
}

// --- Type resolution ---

function resolveInner(raw, tableMap, optionSetMap) {
  if (PRIMITIVES.has(raw)) return raw;
  if (raw === 'user') return 'relation -> User';

  if (raw.startsWith('custom.')) {
    const ref = raw.slice(7);
    const name = tableMap[ref] || `${ref} [?]`;
    return `relation -> ${name}`;
  }
  if (raw.startsWith('option.')) {
    const ref = raw.slice(7);
    const name = optionSetMap[ref] || `${ref} [?]`;
    return `option(${name})`;
  }
  if (raw.startsWith('api.')) {
    return `api(${raw.slice(4)})`;
  }
  return `${raw} [?]`;
}

function resolveType(rawType, tableMap, optionSetMap) {
  if (rawType.startsWith('list.')) {
    const inner = resolveInner(rawType.slice(5), tableMap, optionSetMap);
    return `list<${inner}>`;
  }
  return resolveInner(rawType, tableMap, optionSetMap);
}

// --- Filtering ---

function isDeleted(fieldDef) {
  if (fieldDef['%del'] === true) return true;
  if (typeof fieldDef['%d'] === 'string' && fieldDef['%d'].includes('- deleted')) return true;
  return false;
}

// --- Transform ---

function transformTable(tableKey, tableDef, tableMap, optionSetMap) {
  const displayName = tableDef['%d'];
  const fields = tableDef['%f3'] || {};

  const activeFields = [];
  for (const [, fieldDef] of Object.entries(fields)) {
    if (isDeleted(fieldDef)) continue;
    activeFields.push({
      displayName: fieldDef['%d'],
      type: resolveType(fieldDef['%v'], tableMap, optionSetMap),
      rawType: fieldDef['%v'],
      defaultVal: fieldDef['default_val'],
    });
  }

  const relationCount = activeFields.filter(f => f.type.includes('relation ->')).length;
  return { tableKey, displayName, fields: activeFields, relationCount };
}

// --- Markdown generation ---

function toAnchor(name) {
  return name.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/-+$/, '');
}

function esc(str) {
  if (str == null) return '';
  return String(str).replace(/\|/g, '\\|');
}

function generateMarkdown(tables) {
  const totalFields = tables.reduce((s, t) => s + t.fields.length, 0);
  const lines = [];

  lines.push('# Bubble.io Database Schema');
  lines.push(`> ${tables.length} tables | ${totalFields} active fields`);
  lines.push('');

  // Table of Contents
  lines.push('## Table of Contents');
  lines.push('');
  lines.push('| # | Table Name | Key | Fields | Relations |');
  lines.push('|---|-----------|-----|--------|-----------|');
  tables.forEach((t, i) => {
    const anchor = toAnchor(t.displayName);
    lines.push(`| ${i + 1} | [${t.displayName}](#${anchor}) | \`${t.tableKey}\` | ${t.fields.length} | ${t.relationCount} |`);
  });
  lines.push('');

  // Each table
  for (const table of tables) {
    lines.push('---');
    lines.push('');
    lines.push(`## ${table.displayName}`);
    lines.push(`> Key: \`${table.tableKey}\` | Fields: ${table.fields.length} | Relations: ${table.relationCount}`);
    lines.push('');

    if (table.fields.length === 0) {
      lines.push('*No active fields*');
      lines.push('');
      continue;
    }

    lines.push('| # | Field | Type | Default |');
    lines.push('|---|-------|------|---------|');
    table.fields.forEach((f, i) => {
      const def = f.defaultVal !== undefined ? `\`${f.defaultVal}\`` : '';
      lines.push(`| ${i + 1} | ${esc(f.displayName)} | ${esc(f.type)} | ${def} |`);
    });
    lines.push('');
  }

  return lines.join('\n');
}

// --- Main ---

function main() {
  const userTypes = JSON.parse(fs.readFileSync(USER_TYPES_PATH, 'utf-8'));
  const optionSets = JSON.parse(fs.readFileSync(OPTION_SETS_PATH, 'utf-8'));

  const tableMap = buildTableMap(userTypes);
  const optionSetMap = buildOptionSetMap(optionSets);

  const tables = Object.entries(userTypes)
    .map(([key, def]) => transformTable(key, def, tableMap, optionSetMap))
    .sort((a, b) => a.displayName.localeCompare(b.displayName));

  const markdown = generateMarkdown(tables);

  fs.mkdirSync(path.dirname(OUTPUT_PATH), { recursive: true });
  fs.writeFileSync(OUTPUT_PATH, markdown, 'utf-8');

  console.log(`Output: ${OUTPUT_PATH}`);
  console.log(`Tables: ${tables.length}`);
  console.log(`Active fields: ${tables.reduce((s, t) => s + t.fields.length, 0)}`);

  // Report unresolved references
  const unresolved = [];
  for (const t of tables) {
    for (const f of t.fields) {
      if (f.type.includes('[?]')) {
        unresolved.push(`  ${t.displayName}.${f.displayName}: ${f.rawType}`);
      }
    }
  }
  if (unresolved.length > 0) {
    console.log(`\nUnresolved references (${unresolved.length}):`);
    unresolved.forEach(u => console.log(u));
  }
}

main();
