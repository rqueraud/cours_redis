[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/rqueraud/cours_redis/HEAD)

Test the container with : 
```bash
docker build -t cours_redis .
docker run -it --rm -p 8888:8888 cours_redis jupyter notebook --NotebookApp.default_url=/lab/ --ip=0.0.0.0 --port=8888
```