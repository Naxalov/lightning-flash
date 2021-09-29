docker run --ipc=host --rm --runtime=nvidia -it -p 8888:8888 -v $(pwd)/workspace:'/workspace' flash bash
