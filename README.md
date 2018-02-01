##Steps to execute to build

#To build base builder Image
```
docker build -t echarish/mule-base-builder .
```

*Project structure*
deployments folder has below folder they will be copied at the time of s2i image build process to
image. Place your project files here
- muleprojects
  - apps --> Copy your apps here
  - domains --> Copy your domains here
  - conf --> Copy your conf files here



#To create mule s2i Image
```
s2i build deployments/ echarish/mule-base-builder echarish/mule-s2i--app
```
