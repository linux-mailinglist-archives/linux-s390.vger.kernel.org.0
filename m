Return-Path: <linux-s390+bounces-16147-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIAaOIJBgmlHRQMAu9opvQ
	(envelope-from <linux-s390+bounces-16147-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 03 Feb 2026 19:42:10 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70270DDBE0
	for <lists+linux-s390@lfdr.de>; Tue, 03 Feb 2026 19:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC375302204D
	for <lists+linux-s390@lfdr.de>; Tue,  3 Feb 2026 18:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5293E2F7ACA;
	Tue,  3 Feb 2026 18:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V2uaaR9K"
X-Original-To: linux-s390@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABEC1C5D59;
	Tue,  3 Feb 2026 18:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770144128; cv=none; b=Ot9BFfL+2KBehXhc8p+VCHc4bjVWBZ2gwr1fXPDU38z5Bnp+btvXxwaHyNNGKe63has5w7+dWY7iENi+ObelExibSIy9BNQZpnuc8g9XADFli2kv+XXeaO9x7OETVti1MG6WHoLOBE8pR2baDWzIbhRjJACQm6mUfJgrvlkN21Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770144128; c=relaxed/simple;
	bh=on9CzqZMNBYdJdUhDoCOoIndh3FGCG0oMXhP/EPXYiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nDLE0ccBw2upjjrVyVleVcc2FYXBiyUZLIMnq1B0hh/Z5CyuSgFtunNl17sLPfn0V+1xvkRhLXu9wlptlf8VBYybncV3NOJQigldDECiOP/nPtfpXTFuwqiH6InCAEIshraghmmR+OtEsphgiOuEktF89ZJ0U+B9p2h5Vo3vyJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V2uaaR9K; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=1T0nK4B/roTlnYfgDEOYLsCmvy4h4Son3oPagVD5eN4=; b=V2uaaR9K1Ga1d+3qMMfI8ctAJn
	+QgF7u/u/+7fgkCA4hDQgOvpsLTOt6wKXZHmboek4xQoyVsiOZkmC3RjFyN9tmPWxkp3Kp8XGIncJ
	daHvAgQNjLidGzjljB+cIpoqMtrNw/5x//TkJJWiqIUalJYBdvSMUwQY0EQEiQo408XSrdFYYt7Eu
	9KZEyNOxbi3KSezHlRH5QnEJN+niNxcE2PJ9FiKUDBEC6MyeD7kI1LfDt/XIkYGv24YngkIg91g5z
	Gv9jhMwQlIQW46xwozEO21D57sVMZcvTvpz3sOYmEtpGrHCACyUws7iF8YVWYGnwOUAUgA/hnIZcb
	KzrIPE+g==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnLLi-00000007Aqb-1b88;
	Tue, 03 Feb 2026 18:42:06 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: [PATCH] s390: remove kvm_types.h from Kbuild
Date: Tue,  3 Feb 2026 10:42:04 -0800
Message-ID: <20260203184204.1329414-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16147-lists,linux-s390=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:email,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Queue-Id: 70270DDBE0
X-Rspamd-Action: no action

kvm_types.h is mandatory in include/asm-generic/Kbuild so having it
in another Kbuild file causes a warning. Remove it from the arch/
Kbuild file to fix the warning.

../scripts/Makefile.asm-headers:39: redundant generic-y found in ../arch/s390/include/asm/Kbuild: kvm_types.h

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org

 arch/s390/include/asm/Kbuild |    1 -
 1 file changed, 1 deletion(-)

--- linux-next-20260202.orig/arch/s390/include/asm/Kbuild
+++ linux-next-20260202/arch/s390/include/asm/Kbuild
@@ -5,6 +5,5 @@ generated-y += syscall_table.h
 generated-y += unistd_nr.h
 
 generic-y += asm-offsets.h
-generic-y += kvm_types.h
 generic-y += mcs_spinlock.h
 generic-y += mmzone.h

