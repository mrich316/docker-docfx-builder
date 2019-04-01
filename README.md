# docker-docfx-builder
Docker Image to build docfx documentation

``` shell
git clone https://github.com/mrich316/docker-docfx-builder
docker build -t docfx-builder .
docker run -ti --rm -v $(pwd):/doc docfx-builder init
cd docfx_website
docker run -ti --rm -v $(pwd):/doc docfx-builder build
docker run -ti --rm -v $(pwd):/doc -p 8080:8080 docfx-builder serve _site
```
