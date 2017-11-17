# Pepper Python

A Python Flask application packaged in Habitat

## Build, Run and Test

```shell
$ cd ~/repo
$ hab studio enter
[STUDIO] build
[STUDIO] hab sup start results/ORIGIN-pepper_python-VERSION.hart
[STUDIO] hab pkg install core/curl -b
[STUDIO] curl localhost:5000
```
