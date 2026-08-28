# Set up the development environment

## Prerequsites

This page assumes, you are familiar with Maven and Git flows in general. 
Also, this article is expecting that you are familiar with topics covered in the article about 
[first contributions](../tutorials/first-contribution.md)

## Step 1 

Follow the installation details from the [about section](../../about/installation.md).

## Step 2

Checkout the component, you want to build or to contribute to.
If you are not sure, where to start looking for your first contributions, check 

- plugins in the [Catalogue of existing plugins](../../plugin-developer/reference/plugins-catalog.md), 
- the [Catalogue of existing extensions](../../plugin-developer/reference/extensions-catalog.md) 
- or you might want to check out the [Maven Core](https://github.com/apache/maven)-project on Github.

## Step 3

Build the project in the IDE of your choice with:

```bash
mvn package
```

During this step, all necessary artifacts will be downloaded and the component project itself will be built.

You are now prepared to start your work!
