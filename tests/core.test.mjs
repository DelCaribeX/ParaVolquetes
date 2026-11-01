import test from 'node:test';
import assert from 'node:assert/strict';
import {escapeHTML,totalQuote,csv,validate} from '../public/core.js';
test('user text is escaped before rendering',()=>assert.equal(escapeHTML('<img src=x onerror="x">'), '&lt;img src=x onerror=&quot;x&quot;&gt;'));
test('quote money rounds to cents',()=>assert.equal(totalQuote({quantity:3,unit_price:12.35}),37.05));
test('CSV handles quotes, line breaks and spreadsheet formulas',()=>{const output=csv([{name:'=SUM(1,2)',notes:'a"b\nc'}]);assert.ok(output.includes('"\'=SUM(1,2)"'));assert.ok(output.includes('"a""b\nc"'));});
test('stock rejects fractional and negative amounts',()=>{assert.throws(()=>validate('products',{name:'a',sku:'b',stock:1.5,price:10}));assert.throws(()=>validate('products',{name:'a',sku:'b',stock:-1,price:10}));});
test('quote needs valid references and positive integer quantity',()=>{assert.throws(()=>validate('quotes',{client_id:'x',product_id:'y',quantity:0,unit_price:10}));assert.throws(()=>validate('quotes',{client_id:'',product_id:'y',quantity:1,unit_price:10}));assert.doesNotThrow(()=>validate('quotes',{client_id:'x',product_id:'y',quantity:1,unit_price:10}));});
