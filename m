Return-Path: <linux-s390+bounces-21537-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0broFXaLR2o7awAAu9opvQ
	(envelope-from <linux-s390+bounces-21537-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 03 Jul 2026 12:14:14 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 466D7701103
	for <lists+linux-s390@lfdr.de>; Fri, 03 Jul 2026 12:14:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=fAI6VRdL;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=+CX76KXT;
	dmarc=pass (policy=none) header.from=linutronix.de;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21537-lists+linux-s390=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-s390+bounces-21537-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 97F1A3063EE6
	for <lists+linux-s390@lfdr.de>; Fri,  3 Jul 2026 10:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798FE3CEBB7;
	Fri,  3 Jul 2026 10:03:24 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DD13BBFBF
	for <linux-s390@vger.kernel.org>; Fri,  3 Jul 2026 10:03:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783073004; cv=none; b=KBElT5FGp2zCllM2tXZB2sxrGdHYOrZND1nQID9rfwTaDi4c1C584vTSKC86VR4rTAcm3vVucB0IkZo/c+fN+klloZwZLlRdQdmLYmeW11tHoI6him+2n/yHXFsS4YsjJy6p2ERoX23UYtVib0MhaEW4bNxGM1xaVGyrXLGFJvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783073004; c=relaxed/simple;
	bh=PxavhaJRuFmxG1IwKzPW+rwdDyNvvPmpaNgI2Bb9Mjw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Nskp7eka/mm0rbqgENIBGDYEGJMHG3fZ7U1vkkLRwERitmFmGu7qKGyrYh7Ytcc7gFOd0i+2uGBOnuQGHYEDhAY9I0qJfP95D50jGvmnheeu6rCP9Z8UnEBzGAJbWNaUSJNDRzVh2U/nOVrHyLtdsKDpTfMTOEGFo+KcgaUwMEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fAI6VRdL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+CX76KXT; arc=none smtp.client-ip=193.142.43.55
Date: Fri, 3 Jul 2026 12:03:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783073001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=QYmRaiV8oeov3wzngWSTjPOMEzTQOQCAhf1r9wryG/4=;
	b=fAI6VRdLaAWU6yHvkzSmdbok9Xh6Os13PigmzdqGMpk+MNuFoT4ENbnkUwf52apWC8MJT3
	WBtiNqqgKOQZUXCg9JR96s/LgjjN1Fy21A9zM4Ue8Wrr9rYK0zuqV9Fl/THKdFNkN6oFLe
	EpQtsLly/7LH4ztwBwKWrKxf0GsQtZNKypjOkN1sTB0SppJ9411kTlcXaCIKLdh3merIMk
	tv7Yr+2DZr3o+VsOx9AzwgOeuohlxGGHSZ7qw7KYHHiI7Lh/FQgxU6mUVLPdNodv4OLEDH
	6jk18I4l0ql93q8hGfYN39o/ypF184tFTYb+o3+Tn6zbm4WcBRTHKBR7h9+7kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783073001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=QYmRaiV8oeov3wzngWSTjPOMEzTQOQCAhf1r9wryG/4=;
	b=+CX76KXTZ14Zqaps4c+stGW6PMTqoolDyrKueM1GjeMn2EndmaQQVvh0oqAaCMMeh5KTdA
	HO1e+Gqv8RUuGoBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH] s390/zcrypt: Delete CEX2 and CEX3 device drivers
Message-ID: <20260703100320.qvFoxNbp@linutronix.de>
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
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21537-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-s390@vger.kernel.org,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:freude@linux.ibm.com,m:hca@linux.ibm.com,m:dengler@linux.ibm.com,m:svens@linux.ibm.com,m:gor@linux.ibm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-s390];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linutronix.de:from_mime,linutronix.de:email,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 466D7701103

The two driver were removed in commit 5ac8c72462cda ("s390/zcrypt:
remove CEX2 and CEX3 device drivers") but not deleted. That means they
are still around as zero sized files reminding everyone what once was.

Let's delete them now.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/s390/crypto/zcrypt_cex2a.c | 0
 drivers/s390/crypto/zcrypt_cex2a.h | 0
 drivers/s390/crypto/zcrypt_cex2c.c | 0
 drivers/s390/crypto/zcrypt_cex2c.h | 0
 4 files changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 drivers/s390/crypto/zcrypt_cex2a.c
 delete mode 100644 drivers/s390/crypto/zcrypt_cex2a.h
 delete mode 100644 drivers/s390/crypto/zcrypt_cex2c.c
 delete mode 100644 drivers/s390/crypto/zcrypt_cex2c.h

diff --git a/drivers/s390/crypto/zcrypt_cex2a.c b/drivers/s390/crypto/zcrypt_cex2a.c
deleted file mode 100644
index e69de29bb2d1d..0000000000000
diff --git a/drivers/s390/crypto/zcrypt_cex2a.h b/drivers/s390/crypto/zcrypt_cex2a.h
deleted file mode 100644
index e69de29bb2d1d..0000000000000
diff --git a/drivers/s390/crypto/zcrypt_cex2c.c b/drivers/s390/crypto/zcrypt_cex2c.c
deleted file mode 100644
index e69de29bb2d1d..0000000000000
diff --git a/drivers/s390/crypto/zcrypt_cex2c.h b/drivers/s390/crypto/zcrypt_cex2c.h
deleted file mode 100644
index e69de29bb2d1d..0000000000000
-- 
2.53.0


