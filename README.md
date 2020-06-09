# docker-for-vue-nginx

This Docker repository is built to be used by [Web Whales](https://webwhales.nl) developers to develop VueJS
 applications, but any other developer may use our repository as well.


## Using this image

When you're about to use this image, you can use the files you'll find in the templates folder in [the repository on 
GitHub](https://github.com/WebWhales/docker-for-vue-nginx).

When using our template files, follow these steps to start using this image:
* Copy all files under `/templates` to the root of your project directory
* In the `docker-compose.yml`:
  * Change container names when using multiple docker set ups simultaneously
  * Change the `hostname` directives
    * Tip: the *.localhost tld points to your local machine automatically on Windows
  * Change ports when necessary
* Run `docker-compose up -d` from the root of your project directory


### Bonus: some tips to help you on your way

* The `web` container contains the following command line tools:
  * `nano`
  * `nodejs`, `npm` and `yarn`
  * `@vue/cli`, `gulp-cli` and `gulp`
  * `supervisor`