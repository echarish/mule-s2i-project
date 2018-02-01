# Steps to execute to build

## Step 1
### building the base builder image with Dockerfile
### To build base builder Image
```
docker build -t echarish/mule-base-builder .
```

-----------------------------------------------------------------
## Step 2
*Project structure*

deployments folder has below folder they will be copied at the time of s2i image build process to
image. Place your project files here
- muleprojects
  - apps --> Copy your apps here
  - domains --> Copy your domains here
  - conf --> Copy your conf files here



## To create mule s2i Image
```
s2i build deployments/ echarish/mule-base-builder echarish/mule-s2i-app
```

## Step 3 running the mule project Image
```
docker run --rm -p 8081:8081 echarish/mule-s2i-app
```

## Step 4 access the running apps
http://localhost:8081/s2idemo
