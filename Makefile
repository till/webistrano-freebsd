# New ports collection makefile for:	webistrano
# Date created:				27 June 2009
# Whom:					Till Klampaeckel <till@php.net>
#
# $FreeBSD: $
#

PORTNAME=	webistrano
PORTVERSION=	1.4
CATEGORIES=	www
MASTER_SITES=	http://labs.peritor.com/webistrano/attachment/wiki/Download
EXTRACT_SUFX=	.zip?format=raw
DISTFILES=	${PORTNAME}-${PORTVERSION}.zip

WRKSRC=	${WRKDIR}/${PORTVERSION}

MAINTAINER=	till@php.net
COMMENT=	A web frontend to capistrano.

RUN_DEPENDS=	rubygem-capistrano>=2.4.3:${PORTSDIR}/sysutils/rubygem-capistrano \
		rubygem-mocha>=0.9.5:${PORTSDIR}/devel/rubygem-mocha \
		rubygem-net-scp>=1.0.1:${PORTSDIR}/security/rubygem-net-scp \
		rubygem-net-sftp>=2.0.1:${PORTSDIR}/security/rubygem-net-sftp \
		rubygem-net-ssh>=2.0.2:${PORTSDIR}/security/rubygem-net-ssh \
		rubygem-net-ssh-gateway>=1.0.0:${PORTSDIR}/security/rubygem-net-ssh-gateway \
		rubygem-open4>=0.9.6:${PORTSDIR}/devel/rubygem-open4 \
		rubygem-syntax>=1.0.0:${PORTSDIR}/textproc/rubygem-syntax

OPTIONS=	MYSQL "Use MySQL" on \
		PGSQL "Use PostgreSQL" off \
		SQLITE "Use SQLite" off

.if defined(WITHOUT_MYSQL) && !defined(WITH_PGSQL) && !defined(WITH_SQLITE)
IGNORE=		needs a database backend
.endif

USE_ZIP=	yes
RUBY_VERSION=	1.8.4
USE_RUBY=	yes
USE_RAKE=	yes
NO_BUILD=	yes
PUBLIC_DIR=	public
DELETE_PLUGINS=	capistrano-2.4.3 capistrano-2.5.0 \
		highline-1.4.0 mocha-0.4.0 \
		net-scp-1.0.1 net-sftp-2.0.1 \
		net-ssh-2.0.2 net-ssh-gateway-1.0.0 \
		open4-0.9.3 syntax-1.0.0

do-fetch:
.if !exists(${DISTDIR}/${DISTNAME}.zip)
	${FETCH_CMD} -o ${DISTDIR}/${DISTNAME}.zip ${MASTER_SITES}/${DISTNAME}${EXTRACT_SUFX}
.endif

do-install:
.for x in ${DELETE_PLUGINS}
	-${RM} -rf ${WRKSRC}/vendor/plugins/${x}
.endfor
	${MKDIR} ${WWWDIR}
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
	@${ECHO_MSG} " - execute \"setenv RAILS_ENV production\""
	@${ECHO_MSG} " - execute \"rake db:migrate\""
	@${ECHO_MSG} " - execute \"ruby script/server -d -p 3000 -e production\""
	@${ECHO_MSG}
	@${ECHO_MSG} "======================================================================"

.include <bsd.port.mk>
