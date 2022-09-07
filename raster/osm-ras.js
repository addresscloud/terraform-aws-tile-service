const style = JSON.parse(`{
  "tileJson": "3.0.0",
  "version": 8,
  "name": "OSM Liberty",
  "metadata": {
    "maputnik:license": "https://github.com/maputnik/osm-liberty/blob/gh-pages/LICENSE.md",
    "maputnik:renderer": "mbgljs",
    "openmaptiles:version": "3.x"
  },
  "sources": {
    "openmaptiles": {
      "type": "raster",
      "url": "https://tile-demo.addresscloud.com/v1/tileset/opmras/"
    }
  },
  "layers": [
    {
      "id":"raster",
      "type":"raster",
      "source": "openmaptiles"
    }
  ],
  "id": "osm-liberty"
}`)