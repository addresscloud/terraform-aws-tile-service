var pmtiles = (() => {
  var __defProp = Object.defineProperty;
  var __export = (target, all) => {
    for (var name in all)
      __defProp(target, name, {get: all[name], enumerable: true});
  };
  var __async = (__this, __arguments, generator) => {
    return new Promise((resolve, reject) => {
      var fulfilled = (value) => {
        try {
          step(generator.next(value));
        } catch (e) {
          reject(e);
        }
      };
      var rejected = (value) => {
        try {
          step(generator.throw(value));
        } catch (e) {
          reject(e);
        }
      };
      var step = (x) => x.done ? resolve(x.value) : Promise.resolve(x.value).then(fulfilled, rejected);
      step((generator = generator.apply(__this, __arguments)).next());
    });
  };

  // index.ts
  var js_exports = {};
  __export(js_exports, {
    FetchSource: () => FetchSource,
    FileSource: () => FileSource,
    LRUCacheSource: () => LRUCacheSource,
    PMTiles: () => PMTiles,
    ProtocolCache: () => ProtocolCache,
    createDirectory: () => createDirectory,
    deriveLeaf: () => deriveLeaf,
    getUint24: () => getUint24,
    getUint48: () => getUint48,
    leafletLayer: () => leafletLayer,
    parseEntry: () => parseEntry,
    parseHeader: () => parseHeader,
    queryLeafLevel: () => queryLeafLevel,
    queryLeafdir: () => queryLeafdir,
    queryTile: () => queryTile,
    shift: () => shift,
    sortDir: () => sortDir,
    unshift: () => unshift
  });

  // node_modules/fflate/esm/browser.js
  var u8 = Uint8Array;
  var u16 = Uint16Array;
  var u32 = Uint32Array;
  var fleb = new u8([0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0, 0, 0, 0]);
  var fdeb = new u8([0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13, 0, 0]);
  var clim = new u8([16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15]);
  var freb = function(eb, start) {
    var b = new u16(31);
    for (var i = 0; i < 31; ++i) {
      b[i] = start += 1 << eb[i - 1];
    }
    var r = new u32(b[30]);
    for (var i = 1; i < 30; ++i) {
      for (var j = b[i]; j < b[i + 1]; ++j) {
        r[j] = j - b[i] << 5 | i;
      }
    }
    return [b, r];
  };
  var _a = freb(fleb, 2);
  var fl = _a[0];
  var revfl = _a[1];
  fl[28] = 258, revfl[258] = 28;
  var _b = freb(fdeb, 0);
  var fd = _b[0];
  var revfd = _b[1];
  var rev = new u16(32768);
  for (var i = 0; i < 32768; ++i) {
    x = (i & 43690) >>> 1 | (i & 21845) << 1;
    x = (x & 52428) >>> 2 | (x & 13107) << 2;
    x = (x & 61680) >>> 4 | (x & 3855) << 4;
    rev[i] = ((x & 65280) >>> 8 | (x & 255) << 8) >>> 1;
  }
  var x;
  var hMap = function(cd, mb, r) {
    var s = cd.length;
    var i = 0;
    var l = new u16(mb);
    for (; i < s; ++i) {
      if (cd[i])
        ++l[cd[i] - 1];
    }
    var le = new u16(mb);
    for (i = 0; i < mb; ++i) {
      le[i] = le[i - 1] + l[i - 1] << 1;
    }
    var co;
    if (r) {
      co = new u16(1 << mb);
      var rvb = 15 - mb;
      for (i = 0; i < s; ++i) {
        if (cd[i]) {
          var sv = i << 4 | cd[i];
          var r_1 = mb - cd[i];
          var v = le[cd[i] - 1]++ << r_1;
          for (var m = v | (1 << r_1) - 1; v <= m; ++v) {
            co[rev[v] >>> rvb] = sv;
          }
        }
      }
    } else {
      co = new u16(s);
      for (i = 0; i < s; ++i) {
        if (cd[i]) {
          co[i] = rev[le[cd[i] - 1]++] >>> 15 - cd[i];
        }
      }
    }
    return co;
  };
  var flt = new u8(288);
  for (var i = 0; i < 144; ++i)
    flt[i] = 8;
  for (var i = 144; i < 256; ++i)
    flt[i] = 9;
  for (var i = 256; i < 280; ++i)
    flt[i] = 7;
  for (var i = 280; i < 288; ++i)
    flt[i] = 8;
  var fdt = new u8(32);
  for (var i = 0; i < 32; ++i)
    fdt[i] = 5;
  var flrm = /* @__PURE__ */ hMap(flt, 9, 1);
  var fdrm = /* @__PURE__ */ hMap(fdt, 5, 1);
  var max = function(a) {
    var m = a[0];
    for (var i = 1; i < a.length; ++i) {
      if (a[i] > m)
        m = a[i];
    }
    return m;
  };
  var bits = function(d, p, m) {
    var o = p / 8 | 0;
    return (d[o] | d[o + 1] << 8) >> (p & 7) & m;
  };
  var bits16 = function(d, p) {
    var o = p / 8 | 0;
    return (d[o] | d[o + 1] << 8 | d[o + 2] << 16) >> (p & 7);
  };
  var shft = function(p) {
    return (p + 7) / 8 | 0;
  };
  var slc = function(v, s, e) {
    if (s == null || s < 0)
      s = 0;
    if (e == null || e > v.length)
      e = v.length;
    var n = new (v.BYTES_PER_ELEMENT == 2 ? u16 : v.BYTES_PER_ELEMENT == 4 ? u32 : u8)(e - s);
    n.set(v.subarray(s, e));
    return n;
  };
  var ec = [
    "unexpected EOF",
    "invalid block type",
    "invalid length/literal",
    "invalid distance",
    "stream finished",
    "no stream handler",
    ,
    "no callback",
    "invalid UTF-8 data",
    "extra field too long",
    "date not in range 1980-2099",
    "filename too long",
    "stream finishing",
    "invalid zip data"
  ];
  var err = function(ind, msg, nt) {
    var e = new Error(msg || ec[ind]);
    e.code = ind;
    if (Error.captureStackTrace)
      Error.captureStackTrace(e, err);
    if (!nt)
      throw e;
    return e;
  };
  var inflt = function(dat, buf, st) {
    var sl = dat.length;
    if (!sl || st && st.f && !st.l)
      return buf || new u8(0);
    var noBuf = !buf || st;
    var noSt = !st || st.i;
    if (!st)
      st = {};
    if (!buf)
      buf = new u8(sl * 3);
    var cbuf = function(l2) {
      var bl = buf.length;
      if (l2 > bl) {
        var nbuf = new u8(Math.max(bl * 2, l2));
        nbuf.set(buf);
        buf = nbuf;
      }
    };
    var final = st.f || 0, pos = st.p || 0, bt = st.b || 0, lm = st.l, dm = st.d, lbt = st.m, dbt = st.n;
    var tbts = sl * 8;
    do {
      if (!lm) {
        final = bits(dat, pos, 1);
        var type = bits(dat, pos + 1, 3);
        pos += 3;
        if (!type) {
          var s = shft(pos) + 4, l = dat[s - 4] | dat[s - 3] << 8, t = s + l;
          if (t > sl) {
            if (noSt)
              err(0);
            break;
          }
          if (noBuf)
            cbuf(bt + l);
          buf.set(dat.subarray(s, t), bt);
          st.b = bt += l, st.p = pos = t * 8, st.f = final;
          continue;
        } else if (type == 1)
          lm = flrm, dm = fdrm, lbt = 9, dbt = 5;
        else if (type == 2) {
          var hLit = bits(dat, pos, 31) + 257, hcLen = bits(dat, pos + 10, 15) + 4;
          var tl = hLit + bits(dat, pos + 5, 31) + 1;
          pos += 14;
          var ldt = new u8(tl);
          var clt = new u8(19);
          for (var i = 0; i < hcLen; ++i) {
            clt[clim[i]] = bits(dat, pos + i * 3, 7);
          }
          pos += hcLen * 3;
          var clb = max(clt), clbmsk = (1 << clb) - 1;
          var clm = hMap(clt, clb, 1);
          for (var i = 0; i < tl; ) {
            var r = clm[bits(dat, pos, clbmsk)];
            pos += r & 15;
            var s = r >>> 4;
            if (s < 16) {
              ldt[i++] = s;
            } else {
              var c = 0, n = 0;
              if (s == 16)
                n = 3 + bits(dat, pos, 3), pos += 2, c = ldt[i - 1];
              else if (s == 17)
                n = 3 + bits(dat, pos, 7), pos += 3;
              else if (s == 18)
                n = 11 + bits(dat, pos, 127), pos += 7;
              while (n--)
                ldt[i++] = c;
            }
          }
          var lt = ldt.subarray(0, hLit), dt = ldt.subarray(hLit);
          lbt = max(lt);
          dbt = max(dt);
          lm = hMap(lt, lbt, 1);
          dm = hMap(dt, dbt, 1);
        } else
          err(1);
        if (pos > tbts) {
          if (noSt)
            err(0);
          break;
        }
      }
      if (noBuf)
        cbuf(bt + 131072);
      var lms = (1 << lbt) - 1, dms = (1 << dbt) - 1;
      var lpos = pos;
      for (; ; lpos = pos) {
        var c = lm[bits16(dat, pos) & lms], sym = c >>> 4;
        pos += c & 15;
        if (pos > tbts) {
          if (noSt)
            err(0);
          break;
        }
        if (!c)
          err(2);
        if (sym < 256)
          buf[bt++] = sym;
        else if (sym == 256) {
          lpos = pos, lm = null;
          break;
        } else {
          var add = sym - 254;
          if (sym > 264) {
            var i = sym - 257, b = fleb[i];
            add = bits(dat, pos, (1 << b) - 1) + fl[i];
            pos += b;
          }
          var d = dm[bits16(dat, pos) & dms], dsym = d >>> 4;
          if (!d)
            err(3);
          pos += d & 15;
          var dt = fd[dsym];
          if (dsym > 3) {
            var b = fdeb[dsym];
            dt += bits16(dat, pos) & (1 << b) - 1, pos += b;
          }
          if (pos > tbts) {
            if (noSt)
              err(0);
            break;
          }
          if (noBuf)
            cbuf(bt + 131072);
          var end = bt + add;
          for (; bt < end; bt += 4) {
            buf[bt] = buf[bt - dt];
            buf[bt + 1] = buf[bt + 1 - dt];
            buf[bt + 2] = buf[bt + 2 - dt];
            buf[bt + 3] = buf[bt + 3 - dt];
          }
          bt = end;
        }
      }
      st.l = lm, st.p = lpos, st.b = bt, st.f = final;
      if (lm)
        final = 1, st.m = lbt, st.d = dm, st.n = dbt;
    } while (!final);
    return bt == buf.length ? buf : slc(buf, 0, bt);
  };
  var et = /* @__PURE__ */ new u8(0);
  var gzs = function(d) {
    if (d[0] != 31 || d[1] != 139 || d[2] != 8)
      err(6, "invalid gzip data");
    var flg = d[3];
    var st = 10;
    if (flg & 4)
      st += d[10] | (d[11] << 8) + 2;
    for (var zs = (flg >> 3 & 1) + (flg >> 4 & 1); zs > 0; zs -= !d[st++])
      ;
    return st + (flg & 2);
  };
  var gzl = function(d) {
    var l = d.length;
    return (d[l - 4] | d[l - 3] << 8 | d[l - 2] << 16 | d[l - 1] << 24) >>> 0;
  };
  var zlv = function(d) {
    if ((d[0] & 15) != 8 || d[0] >>> 4 > 7 || (d[0] << 8 | d[1]) % 31)
      err(6, "invalid zlib data");
    if (d[1] & 32)
      err(6, "invalid zlib data: preset dictionaries not supported");
  };
  function inflateSync(data, out) {
    return inflt(data, out);
  }
  function gunzipSync(data, out) {
    return inflt(data.subarray(gzs(data), -8), out || new u8(gzl(data)));
  }
  function unzlibSync(data, out) {
    return inflt((zlv(data), data.subarray(2, -4)), out);
  }
  function decompressSync(data, out) {
    return data[0] == 31 && data[1] == 139 && data[2] == 8 ? gunzipSync(data, out) : (data[0] & 15) != 8 || data[0] >> 4 > 7 || (data[0] << 8 | data[1]) % 31 ? inflateSync(data, out) : unzlibSync(data, out);
  }
  var te = typeof TextEncoder != "undefined" && /* @__PURE__ */ new TextEncoder();
  var td = typeof TextDecoder != "undefined" && /* @__PURE__ */ new TextDecoder();
  var tds = 0;
  try {
    td.decode(et, {stream: true});
    tds = 1;
  } catch (e) {
  }
  var mt = typeof queueMicrotask == "function" ? queueMicrotask : typeof setTimeout == "function" ? setTimeout : function(fn) {
    fn();
  };

  // index.ts
  var shift = (n, shift2) => {
    return n * Math.pow(2, shift2);
  };
  var unshift = (n, shift2) => {
    return Math.floor(n / Math.pow(2, shift2));
  };
  var getUint24 = (view, pos) => {
    return shift(view.getUint16(pos + 1, true), 8) + view.getUint8(pos);
  };
  var getUint48 = (view, pos) => {
    return shift(view.getUint32(pos + 2, true), 16) + view.getUint16(pos, true);
  };
  var compare = (tz, tx, ty, view, i) => {
    if (tz != view.getUint8(i))
      return tz - view.getUint8(i);
    const x = getUint24(view, i + 1);
    if (tx != x)
      return tx - x;
    const y = getUint24(view, i + 4);
    if (ty != y)
      return ty - y;
    return 0;
  };
  var queryLeafdir = (view, z, x, y) => {
    const offset_len = queryView(view, z | 128, x, y);
    if (offset_len) {
      return {
        z,
        x,
        y,
        offset: offset_len[0],
        length: offset_len[1],
        is_dir: true
      };
    }
    return null;
  };
  var queryTile = (view, z, x, y) => {
    const offset_len = queryView(view, z, x, y);
    if (offset_len) {
      return {
        z,
        x,
        y,
        offset: offset_len[0],
        length: offset_len[1],
        is_dir: false
      };
    }
    return null;
  };
  var queryView = (view, z, x, y) => {
    let m = 0;
    let n = view.byteLength / 17 - 1;
    while (m <= n) {
      const k = n + m >> 1;
      const cmp = compare(z, x, y, view, k * 17);
      if (cmp > 0) {
        m = k + 1;
      } else if (cmp < 0) {
        n = k - 1;
      } else {
        return [getUint48(view, k * 17 + 7), view.getUint32(k * 17 + 13, true)];
      }
    }
    return null;
  };
  var queryLeafLevel = (view) => {
    if (view.byteLength < 17)
      return null;
    const numEntries = view.byteLength / 17;
    const entry = parseEntry(view, numEntries - 1);
    if (entry.is_dir)
      return entry.z;
    return null;
  };
  var entrySort = (a, b) => {
    if (a.is_dir && !b.is_dir) {
      return 1;
    }
    if (!a.is_dir && b.is_dir) {
      return -1;
    }
    if (a.z !== b.z) {
      return a.z - b.z;
    }
    if (a.x !== b.x) {
      return a.x - b.x;
    }
    return a.y - b.y;
  };
  var parseEntry = (dataview, i) => {
    const z_raw = dataview.getUint8(i * 17);
    const z = z_raw & 127;
    return {
      z,
      x: getUint24(dataview, i * 17 + 1),
      y: getUint24(dataview, i * 17 + 4),
      offset: getUint48(dataview, i * 17 + 7),
      length: dataview.getUint32(i * 17 + 13, true),
      is_dir: z_raw >> 7 === 1
    };
  };
  var sortDir = (dataview) => {
    const entries = [];
    for (let i = 0; i < dataview.byteLength / 17; i++) {
      entries.push(parseEntry(dataview, i));
    }
    return createDirectory(entries);
  };
  var createDirectory = (entries) => {
    entries.sort(entrySort);
    const buffer = new ArrayBuffer(17 * entries.length);
    const arr = new Uint8Array(buffer);
    for (let i = 0; i < entries.length; i++) {
      const entry = entries[i];
      let z = entry.z;
      if (entry.is_dir)
        z = z | 128;
      arr[i * 17] = z;
      arr[i * 17 + 1] = entry.x & 255;
      arr[i * 17 + 2] = entry.x >> 8 & 255;
      arr[i * 17 + 3] = entry.x >> 16 & 255;
      arr[i * 17 + 4] = entry.y & 255;
      arr[i * 17 + 5] = entry.y >> 8 & 255;
      arr[i * 17 + 6] = entry.y >> 16 & 255;
      arr[i * 17 + 7] = entry.offset & 255;
      arr[i * 17 + 8] = unshift(entry.offset, 8) & 255;
      arr[i * 17 + 9] = unshift(entry.offset, 16) & 255;
      arr[i * 17 + 10] = unshift(entry.offset, 24) & 255;
      arr[i * 17 + 11] = unshift(entry.offset, 32) & 255;
      arr[i * 17 + 12] = unshift(entry.offset, 48) & 255;
      arr[i * 17 + 13] = entry.length & 255;
      arr[i * 17 + 14] = entry.length >> 8 & 255;
      arr[i * 17 + 15] = entry.length >> 16 & 255;
      arr[i * 17 + 16] = entry.length >> 24 & 255;
    }
    return new DataView(arr.buffer, arr.byteOffset, arr.length);
  };
  var deriveLeaf = (root, tile) => {
    const leaf_level = queryLeafLevel(root.dir);
    if (leaf_level) {
      const level_diff = tile.z - leaf_level;
      const leaf_x = Math.trunc(tile.x / (1 << level_diff));
      const leaf_y = Math.trunc(tile.y / (1 << level_diff));
      return {z: leaf_level, x: leaf_x, y: leaf_y};
    }
    return null;
  };
  var parseHeader = (dataview) => {
    const magic = dataview.getUint16(0, true);
    if (magic !== 19792) {
      throw new Error('File header does not begin with "PM"');
    }
    const version = dataview.getUint16(2, true);
    const json_size = dataview.getUint32(4, true);
    const root_entries = dataview.getUint16(8, true);
    return {
      version,
      json_size,
      root_entries
    };
  };
  var FileSource = class {
    constructor(file) {
      this.file = file;
    }
    getKey() {
      return this.file.name;
    }
    getBytes(offset, length) {
      return __async(this, null, function* () {
        let blob = this.file.slice(offset, offset + length);
        let a = yield blob.arrayBuffer();
        return new DataView(a);
      });
    }
  };
  var FetchSource = class {
    constructor(url) {
      this.url = url;
    }
    getKey() {
      return this.url;
    }
    getBytes(offset, length) {
      return __async(this, null, function* () {
        const controller = new AbortController();
        const signal = controller.signal;
        const resp = yield fetch(this.url, {
          signal,
          headers: {Range: "bytes=" + offset + "-" + (offset + length - 1), 'x-api-key': "DEMO-KEY-b91ed57f-5438-4d99-a17e-6723610f7ad9"}
        });
        const contentLength = resp.headers.get("Content-Length");
        if (!contentLength || +contentLength !== length) {
          console.error("Content-Length mismatch indicates byte serving not supported; aborting.");
          controller.abort();
        }
        const a = yield resp.arrayBuffer();
        return new DataView(a);
      });
    }
  };
  var LRUCacheSource = class {
    constructor(source, maxEntries) {
      this.getKey = () => {
        return this.source.getKey();
      };
      this.source = source;
      this.entries = new Map();
      this.maxEntries = maxEntries;
    }
    getBytes(offset, length) {
      return __async(this, null, function* () {
        let val = this.entries.get(offset + "-" + length);
        if (val) {
          val.lastUsed = performance.now();
          return val.buffer;
        }
        let promise = this.source.getBytes(offset, length);
        this.entries.set(offset + "-" + length, {
          lastUsed: performance.now(),
          buffer: promise
        });
        if (this.entries.size > this.maxEntries) {
          let minUsed = Infinity;
          let minKey = void 0;
          this.entries.forEach((val2, key) => {
            if (val2.lastUsed < minUsed) {
              minUsed = val2.lastUsed;
              minKey = key;
            }
          });
          if (minKey)
            this.entries.delete(minKey);
        }
        return promise;
      });
    }
  };
  var PMTiles = class {
    constructor(source, maxLeaves = 64) {
      if (typeof source === "string") {
        this.source = new LRUCacheSource(new FetchSource(source), maxLeaves);
      } else {
        this.source = source;
      }
    }
    fetchRoot() {
      return __async(this, null, function* () {
        const v = yield this.source.getBytes(0, 512e3);
        const header = parseHeader(new DataView(v.buffer, v.byteOffset, 10));
        let root_dir = new DataView(v.buffer, 10 + header.json_size, 17 * header.root_entries);
        if (header.version === 1) {
          console.warn("Sorting pmtiles v1 directory");
          root_dir = sortDir(root_dir);
        }
        return {
          header,
          view: v,
          dir: root_dir
        };
      });
    }
    root_entries() {
      return __async(this, null, function* () {
        const root = yield this.fetchRoot();
        let entries = [];
        for (var i = 0; i < root.header.root_entries; i++) {
          entries.push(parseEntry(root.dir, i));
        }
        return entries;
      });
    }
    metadata() {
      return __async(this, null, function* () {
        const root = yield this.fetchRoot();
        const dec = new TextDecoder("utf-8");
        const result = JSON.parse(dec.decode(new DataView(root.view.buffer, root.view.byteOffset + 10, root.header.json_size)));
        if (result.compression) {
          console.warn(`Archive has compression type: ${result.compression} and may not be readable directly by browsers.`);
        }
        if (!result.bounds) {
          console.warn(`Archive is missing 'bounds' in metadata, required in v2 and above.`);
        }
        if (!result.minzoom) {
          console.warn(`Archive is missing 'minzoom' in metadata, required in v2 and above.`);
        }
        if (!result.maxzoom) {
          console.warn(`Archive is missing 'maxzoom' in metadata, required in v2 and above.`);
        }
        return result;
      });
    }
    fetchLeafdir(version, entry) {
      return __async(this, null, function* () {
        let buf = yield this.source.getBytes(entry.offset, entry.length);
        if (version === 1) {
          console.warn("Sorting pmtiles v1 directory.");
          buf = sortDir(buf);
        }
        return buf;
      });
    }
    getLeafdir(version, entry) {
      return __async(this, null, function* () {
        return this.fetchLeafdir(version, entry);
      });
    }
    getZxy(z, x, y) {
      return __async(this, null, function* () {
        const root = yield this.fetchRoot();
        const entry = queryTile(new DataView(root.dir.buffer, root.dir.byteOffset, root.dir.byteLength), z, x, y);
        if (entry)
          return entry;
        const leafcoords = deriveLeaf(root, {z, x, y});
        if (leafcoords) {
          const leafdir_entry = queryLeafdir(new DataView(root.dir.buffer, root.dir.byteOffset, root.dir.byteLength), leafcoords.z, leafcoords.x, leafcoords.y);
          if (leafdir_entry) {
            const leafdir = yield this.getLeafdir(root.header.version, leafdir_entry);
            return queryTile(new DataView(leafdir.buffer, leafdir.byteOffset, leafdir.byteLength), z, x, y);
          }
        }
        return null;
      });
    }
  };
  var leafletLayer = (source, options) => {
    const cls = L.GridLayer.extend({
      createTile: function(coord, done) {
        const tile = document.createElement("img");
        source.getZxy(coord.z, coord.x, coord.y).then((result) => {
          if (result === null)
            return;
          const controller = new AbortController();
          const signal = controller.signal;
          tile.cancel = () => {
            controller.abort();
          };
          source.source.getBytes(result.offset, result.length).then((buf) => {
            const blob = new Blob([buf], {type: "image/png"});
            const imageUrl = window.URL.createObjectURL(blob);
            tile.src = imageUrl;
            tile.cancel = null;
            done(null, tile);
          }).catch((error) => {
            if (error.name !== "AbortError")
              throw error;
          });
        });
        return tile;
      },
      _removeTile: function(key) {
        const tile = this._tiles[key];
        if (!tile) {
          return;
        }
        if (tile.el.cancel)
          tile.el.cancel();
        tile.el.width = 0;
        tile.el.height = 0;
        tile.el.deleted = true;
        L.DomUtil.remove(tile.el);
        delete this._tiles[key];
        this.fire("tileunload", {
          tile: tile.el,
          coords: this._keyToTileCoords(key)
        });
      }
    });
    return new cls(options);
  };
  var ProtocolCache = class {
    constructor() {
      this.protocol = (params, callback) => {
        const re = new RegExp(/pmtiles:\/\/(.+)\/(\d+)\/(\d+)\/(\d+)/);
        const result = params.url.match(re);
        const pmtiles_url = result[1];
        let instance = this.tiles.get(pmtiles_url);
        if (!instance) {
          instance = new PMTiles(pmtiles_url);
          this.tiles.set(pmtiles_url, instance);
        }
        const z = result[2];
        const x = result[3];
        const y = result[4];
        let cancel = () => {
        };
        instance.getZxy(+z, +x, +y).then((val) => {
          if (val) {
            instance.source.getBytes(val.offset, val.length).then((arr) => {
              let data = new Uint8Array(arr.buffer);
              if (data[0] == 31 && data[1] == 139) {
                data = decompressSync(data);
              }
              callback(null, data, null, null);
            }).catch((e) => {
              callback(new Error("Canceled"), null, null, null);
            });
          } else {
            callback(null, new Uint8Array(), null, null);
          }
        });
        return {
          cancel: () => {
            cancel();
          }
        };
      };
      this.tiles = new Map();
    }
    add(p) {
      this.tiles.set(p.source.getKey(), p);
    }
    get(url) {
      return this.tiles.get(url);
    }
  };
  return js_exports;
})();
