# New ports collection makefile for:	webistrano
# Date created:				27 June 2009
# Whom:					Till Klampaeckel <till@php.net>
#
# $FreeBSD: $
#

PORTNAME=	webistrano
PORTVERSION=	1.4
CATEGORIES=	www devel
MASTER_SITES=	http://labs.peritor.com/webistrano/raw-attachment/wiki/Download/

MAINTAINER=	till@php.net
COMMENT=	A web frontend to manage deployment through capistrano

RUN_DEPENDS=	rubygem-capistrano>=2.4.3:${PORTSDIR}/sysutils/rubygem-capistrano \
		rubygem-mocha>=0.9.5:${PORTSDIR}/devel/rubygem-mocha \
		rubygem-net-scp>=1.0.1:${PORTSDIR}/security/rubygem-net-scp \
		rubygem-net-sftp>=2.0.1:${PORTSDIR}/security/rubygem-net-sftp \
		rubygem-net-ssh>=2.0.2:${PORTSDIR}/security/rubygem-net-ssh \
		rubygem-net-ssh-gateway>=1.0.0:${PORTSDIR}/security/rubygem-net-ssh-gateway \
		rubygem-open4>=0.9.6:${PORTSDIR}/devel/rubygem-open4 \
		rubygem-syntax>=1.0.0:${PORTSDIR}/textproc/rubygem-syntax \
		rubygem-thin>=1.2.2:${PORTSDIR}/www/rubygem-thin

#RUN_DEPENDS+=	rubygem-activerecord>=2.1.1:${PORTSDIR}/databases/rubygem-activerecord

WRKSRC=	${WRKDIR}/${PORTVERSION}

WEBISTRANO_VARDIR?=	/var
WEBISTRANO_LOGDIR?=	${WEBISTRANO_VARDIR}/log/webistrano
WEBISTRANO_RUNDIR?=	${WEBISTRANO_VARDIR}/run/webistrano
WEBISTRANO_USER?=	${WWWOWN}

USE_RC_SUBR=	webistrano
USE_ZIP=	yes
RUBY_VERSION=	1.8.4
USE_RUBY=	yes
USE_RAKE=	yes
NO_BUILD=	yes

DELETE_PLUGINS=	capistrano-2.4.3 capistrano-2.5.0 \
		highline-1.4.0 mocha-0.4.0 \
		net-scp-1.0.1 net-sftp-2.0.1 \
		net-ssh-2.0.2 net-ssh-gateway-1.0.0 \
		open4-0.9.3 syntax-1.0.0

do-install:
.for x in ${DELETE_PLUGINS}
	-${RM} -rf ${WRKSRC}/vendor/plugins/${x}
.endfor
	${MKDIR} ${WWWDIR}
	@cd ${WRKSRC} && ${COPYTREE_SHARE} \* ${WWWDIR}
	@${CHOWN} -R ${WEBISTRANO_USER} ${WWWDIR}

post-install:
	${MKDIR} ${WEBISTRANO_LOGDIR} ${WEBISTRANO_RUNDIR}
	@${CHOWN} ${WEBISTRANO_USER} ${WEBISTRANO_LOGDIR} ${WEBISTRANO_RUNDIR}

.include <bsd.port.mk>
