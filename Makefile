# New ports collection makefile for:	webistrano
# Date created:				27 June 2009
# Whom:					Till Klampaeckel <till@php.net>
#
# $FreeBSD: $
#

PORTNAME=	webistrano
PORTVERSION=	1.4
CATEGORIES=	www
MASTER_SITES=	http://labs.peritor.com/webistrano/attachment/wiki/Download/
EXTRACT_SUFX=	.zip?format=raw

WRKSRC=	${WRKDIR}/${PORTVERSION}

MAINTAINER=	till@php.net
COMMENT=	A web frontend to capistrano.

#RUN_DEPENDS=	rubygem-capistrano>=2.2.5:${PORTSDIR}/sysutils/rubygem-capistrano 
EXTRACT_DEPENDS=	unzip:${PORTSDIR}/archivers/unzip

USE_ZIP=	yes
USE_RUBY=	yes
USE_RAKE=	yes
NO_BUILD=	yes
PUBLIC_DIR=	public

do-install:
	-${MKDIR} ${WWWDIR}
	@cd ${WRKSRC} && ${COPYTREE_SHARE} \* ${WWWDIR}
.for i in ${PUBLIC_DIR}
	@${CHMOD} 777 ${WWWDIR}/${i}
.endfor
	@${CHOWN} -R ${WWWOWN}:${WWWGRP} ${WWWDIR}
	@${CAT} ${PKGMESSAGE}

post-install:
	@${ECHO_MSG} "======================================================================"
	@${ECHO_MSG}
	@${ECHO_MSG} "Finish the installation in ${WWWDIR} with:"
	@${ECHO_MSG} " - copy config/webistrano_config.rb.sample to config/webistrano_config.rb and edit"
	@${ECHO_MSG} " - copy config/database.yml.sample to config/database.yml and edit"
	@${ECHO_MSG} " - create a database [mysql, pgsql, sqlite]"
	@${ECHO_MSG} " - execute \"RAILS_ENV=production rake db:migrate.\""
	@${ECHO_MSG} " - ruby script/server -d -p 3000 -e production"
	@${ECHO_MSG}
	@${ECHO_MSG} "======================================================================"

.include <bsd.port.mk>
