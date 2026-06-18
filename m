Return-Path: <linux-s390+bounces-21009-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uGWpJxsZNGrdOQYAu9opvQ
	(envelope-from <linux-s390+bounces-21009-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jun 2026 18:13:15 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C306A184D
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jun 2026 18:13:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=mail202007.waldi.user header.b=auN3NXQu;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21009-lists+linux-s390=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-s390+bounces-21009-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 944313002F49
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jun 2026 16:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F5A341ADF;
	Thu, 18 Jun 2026 16:12:49 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail.thinkmo.de (s3.thinkmo.de [162.55.237.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18324318B9D;
	Thu, 18 Jun 2026 16:12:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781799169; cv=none; b=jTgOVVFeL5lE+hCIpH526W0PKJUlSYAlwd7+xFS3nB+tvdHBNoZQp8BS6LEzju94jkh2g+ZBlYTz7ghQbH3KUfPf8N4ccFcUMs+vOjUyYBbcoO0Xp/XBemV9c/oAsjPxz88/2TosbThbZ5/m2B/Rt9fiN+puCIIx6/G7+sdZTV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781799169; c=relaxed/simple;
	bh=Y0hSU5Muuu27iLtzI4T2A81FmRdd/1ugKrH06zB+cXU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=peRcdw4EirqyAz+VGypcvDlkdbCY+zbGbZNQJISoaoJxuxLf3ZrAZuBDWqesJ/saPQ//GGNPhiuvGmxy3xavFgp3b+D33/JESkZ2YzpzyIGlee/5XaugPZZZPdoUPnGKJi2QgMjJL8CgbLvIpgV5DX7KJ4N8uWDtdnjqhSxEB0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=fail smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=auN3NXQu; arc=none smtp.client-ip=162.55.237.202
Received: from localhost (localhost [127.0.0.1])
	by mail.thinkmo.de (Postfix) with ESMTP id 4gh5NW3SCyz10BB;
	Thu, 18 Jun 2026 16:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=debian.org; h=
	content-disposition:content-type:content-type:mime-version
	:message-id:subject:subject:from:from:date:date:received
	:received; s=mail202007.waldi.user; t=1781799163; bh=/spts2B9BTl
	Ek2Y6sRR5rYVYukzdj80Tm20y/wRt3mU=; b=auN3NXQuifNtoHAOCDVd4mZytw+
	MQksd1uAWSD1Uh6OeVX4TssXA6/26C1hSTe/sOu/iwHMLn0yljXRt8HlWSEbapYf
	/urgq3r3nZ5RAfhpMd4mk7eOqdpYaVrO1X3Vj48J9H5AGOoiU/MqqQJxnreccgdA
	ixEQpHDkSdC+0pHtI4KXJjy5z49dJNmbRuBtfCvvr3wMHyUvfr4yn4Td0vRa7bvW
	8DwzKuq5keVCJD3QeE2p6hjbiXcrPOjoGTmsupyD4GzrBvF9cYT1h6hkG2Zh8PqI
	rX0RZTX/tDTqcVpV5FOAzHvSxn7hLaCdmeMs4KlmGCFBznUnu1+FaZXaWmw==
X-Virus-Scanned: Debian amavis at 
Received: from mail.thinkmo.de ([127.0.0.1])
 by localhost (mail.thinkmo.de [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VqpjMkekZKFS; Thu, 18 Jun 2026 16:12:43 +0000 (UTC)
Received: from steamhammer.waldi.eu.org (unknown [IPv6:2a02:8071:5af1:6518:ad11:fa76:980a:620e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.thinkmo.de (Postfix) with ESMTPSA id 4gh5NW24cnzyqB;
	Thu, 18 Jun 2026 16:12:43 +0000 (UTC)
Date: Thu, 18 Jun 2026 18:12:42 +0200
From: Bastian Blank <waldi@debian.org>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: Add build salt to the vDSO
Message-ID: <ajQY-s7Y4mNPQfgy@steamhammer.waldi.eu.org>
Mail-Followup-To: Bastian Blank <waldi@debian.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=mail202007.waldi.user];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21009-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:linux-s390@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[waldi@debian.org,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[waldi@debian.org,linux-s390@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90C306A184D

The vDSO needs to have a unique build id in a similar manner
to the kernel and modules. Use the build salt macro.

Signed-off-by: Bastian Blank <waldi@debian.org>
---
 arch/s390/kernel/vdso/note.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/kernel/vdso/note.S b/arch/s390/kernel/vdso/note.S
index db19d0680a0a..d215781f26b5 100644
--- a/arch/s390/kernel/vdso/note.S
+++ b/arch/s390/kernel/vdso/note.S
@@ -4,6 +4,7 @@
  * Here we can supply some information useful to userland.
  */
 
+#include <linux/build-salt.h>
 #include <linux/uts.h>
 #include <linux/version.h>
 #include <linux/elfnote.h>
@@ -11,3 +12,5 @@
 ELFNOTE_START(Linux, 0, "a")
 	.long LINUX_VERSION_CODE
 ELFNOTE_END
+
+BUILD_SALT
-- 
2.53.0

