String linkImage(String url, int sizeX, int sizeY) {
  url = url.substring(0, url.indexOf("%"));
  return url = "https://$url${sizeX}x$sizeY";
}