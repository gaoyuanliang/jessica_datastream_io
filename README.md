# jessica_datastream_io


```bash
docker build -t gaoyuanliang/jessica_datastream_docker:1.0.1 .

docker run -it \
-m 10g \
-p 5601:5601 \
-p 9200:9200 \
gaoyuanliang/jessica_datastream_docker:1.0.1 \
bash
```

```bash
/jessica/elasticsearch-5.6.1/bin/elasticsearch &
/jessica/kibana-5.6.1-linux-x86_64/bin/kibana &

dsio --es examples/data/cardata_sample.csv
```

view the dashboard at http://0.0.0.0:5601
view the indeces at Elasticsearch at http://0.0.0.0:9200/_cat/indices?v
