const style = JSON.parse(`{
  "tileJson": "3.0.0",
  "version": 8,
  "name": "OSM Liberty",
  "sources": {
    "sentinel": {
      "type": "raster",
      "url": "https://tile-demo.addresscloud.com/v1/tileset/esas2b/"
    }
  },
  "layers": [
    {
      "id":"raster",
      "type":"raster",
      "source": "sentinel"
    }
  ],
  "id": "sentinel"
}`)