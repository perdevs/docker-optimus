FROM perceptive/docker-php53

RUN chmod u+x /usr/local/bin/apache2-foreground
RUN chmod u+x /usr/local/bin/docker-php-ext-*

RUN apt-get update && apt-get install -y freetds-dev locate

RUN ln -s /usr/lib/x86_64-linux-gnu/libsybdb.so /usr/lib/libsybdb.so && ldconfig -v
RUN ln -s /usr/lib/x86_64-linux-gnu/libsybdb.a /usr/lib/libsybdb.a && ldconfig -v

RUN apt-get update && apt-get install -y \
#	subversion \
#	libmcrypt-dev \
#	freetds-dev  \
	curl \
#	git \
	zlib1g-dev \
	mysql-client \
	&& docker-php-ext-configure sybase_ct --with-sybase-ct=shared,/usr \ 
	&& docker-php-ext-install pdo_dblib \ 
#	&& docker-php-ext-install mcrypt \
	&& docker-php-ext-install pcntl \
	&& docker-php-ext-install mbstring \
	&& docker-php-ext-install zip \
	&& docker-php-ext-install pcntl \
	&& docker-php-ext-install bcmath \
	&& docker-php-ext-install pdo_mysql \
	&& docker-php-ext-install mssql \ 
	&& docker-php-ext-install soap  
#	&& docker-php-ext-install libnusoap-php \

#	&& php5-mcrypt \
#	&& php5-mbstring \
#	&& php5-zip \
#	&& php5-pcntl \
#	&& php5-bcmath \
#	&& php5-pdo_mysql \
#	&& php5-sybase \
#	&& php-soap \
#	&& libnusoap-php \
#	&& php5-curl

RUN 	docker-php-ext-install curl  

ADD php.ini /usr/local/etc/php 
RUN echo 'export PHP=/usr/local/bin/php' >> /etc/bash.bashrc
RUN a2enmod rewrite


ADD site-optimus.conf /etc/apache2/sites-available
RUN a2dissite 000-default.conf
RUN a2ensite site-optimus.conf

RUN echo '127.0.0.1 optimus.localhost.com' >> /etc/hosts

RUN echo $PATH

RUN ls -la /usr/local/bin

#CMD ["apache2-foreground"]
