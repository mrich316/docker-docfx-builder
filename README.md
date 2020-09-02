# docker-docfx-builder
Docker Image to build docfx documentation

``` shell
git clone https://github.com/mrich316/docker-docfx-builder
docker build -t docfx-builder .
docker run -ti --rm -v $(pwd):/doc docfx-builder init -o docfx_project
cd docfx_project
docker run -ti --rm -v $(pwd):/doc docfx-builder build /doc/docfx_project/docfx.json
docker run -ti --rm -v $(pwd):/doc -p 8080:8080 docfx-builder serve /doc/docfx_project/_site
```
