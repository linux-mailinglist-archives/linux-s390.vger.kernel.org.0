Return-Path: <linux-s390+bounces-16674-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCcFNGhDpWld7QUAu9opvQ
	(envelope-from <linux-s390+bounces-16674-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 02 Mar 2026 08:59:36 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A633F1D4455
	for <lists+linux-s390@lfdr.de>; Mon, 02 Mar 2026 08:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EBD4B3016AD7
	for <lists+linux-s390@lfdr.de>; Mon,  2 Mar 2026 07:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6385738BF81;
	Mon,  2 Mar 2026 07:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p8FqyHOm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NP4qPJlE"
X-Original-To: linux-s390@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F9C3876C3;
	Mon,  2 Mar 2026 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772438336; cv=none; b=kt21sGpqWToVxzOcb5dIFhvcPMdf+H7a2FcxJQg8AQFUCy7YgoFbKduJKyiLdbgMOz8JKIzVfHX15kaLC4RDEH1HjgpcjK3AUlASenCrVHykh2kk2XB2xLYOGhX+cyj4lwPuZHXzS3uthSW/lf5NmZ0WO4NFbF6aiij2uJ08NU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772438336; c=relaxed/simple;
	bh=rruAPBqVSw+HPUqu0oOkWelmtswIYn2lhLTqTiJ53vE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KvkzCEuiBBCn1I2oezmVll0n6zo75D7bLPn0n27mFWBeYtrvsg4GA3rSHAsMhEzamirj2/cOddqUOgmx0S21waIyF9O9J1EPhxFzZbnZg4ZxwGjcYpbuuPIJWEseSv72oVRTPbAJlWNmQZKOwzEqB2+9mWDcSa2Um479NW162+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p8FqyHOm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NP4qPJlE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772438332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7mI2rabXaAbR/YnFrW0tM4r08T3dQVWOtIR4ie4zo3o=;
	b=p8FqyHOmkJHYpPNhYhThF45B8NXfjuqeW+KMfD5NSW9slZ2D4dzWmXRdwTy+zwB7hmgeyp
	AIqtPPv02rHjZuORVE4prl2ouDsyZAuf4VbIczoF4L+WQpPOY99MUuDzBW3iplsio1sdvO
	KvSGB1GT/HEwoEaIn6hMflsAk/TIkaawbL+tPgUWWqcacZXLj8oxRhsXPP4AXkz5u+/0ZF
	kMKJXzxj0tEvWDN3SpNXOT6UReGvlzcQ+oZP0E0j697ochamdnqIIXB1AihPSC5MqDLQ+P
	dSmv9tBH7s5JpOHa1wzR/iE4sexOuiyjF63ZkaIyau09sJbUxOkUQzgUXyd9Dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772438332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7mI2rabXaAbR/YnFrW0tM4r08T3dQVWOtIR4ie4zo3o=;
	b=NP4qPJlEsfbZcsJh2MCzm7yhxzQLQGDYH6J0mbdc3AB7YcExGhGSt0Qf6n+bYKzrMJe4MN
	8Kj4DO9dM580BrCg==
Date: Mon, 02 Mar 2026 08:58:41 +0100
Subject: [PATCH v2 5/5] asm-generic/bitsperlong.h: Add sanity checks for
 __BITS_PER_LONG
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260302-vdso-compat-checkflags-v2-5-78e55baa58ba@linutronix.de>
References: <20260302-vdso-compat-checkflags-v2-0-78e55baa58ba@linutronix.de>
In-Reply-To: <20260302-vdso-compat-checkflags-v2-0-78e55baa58ba@linutronix.de>
To: "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, 
 David Laight <david.laight.linux@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772438327; l=1561;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=rruAPBqVSw+HPUqu0oOkWelmtswIYn2lhLTqTiJ53vE=;
 b=jsEuD2JRemugj3Kh+6TKAD0gkuvtmrqxpibTTZZ8prtNXAz7vSKNElj3VZrERLX5EQ/DGzIub
 eOVRbIPOYXuD+pT3ErAQIm4w1IhPu9WROaT/REZDfb6RlybADa6wjC7
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16674-lists,linux-s390=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,gaisler.com,kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,linux.ibm.com,ellerman.id.au,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lists.ozlabs.org,linutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-s390];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,linutronix.de:mid,linutronix.de:dkim,linutronix.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A633F1D4455
X-Rspamd-Action: no action

The value of __BITS_PER_LONG from architecture-specific logic should
always match the generic one if that is available. It should also match
the actual C type 'long'.

Mismatches can happen for example when building the compat vDSO. Either
during the compilation, see commit 9a6d3ff10f7f ("arm64: uapi: Provide
correct __BITS_PER_LONG for the compat vDSO"), or when running sparse
when mismatched CHECKFLAGS are inherited from the kernel build.

Add some consistency checks which detect such issues early and clearly.

The kernel-internal BITS_PER_LONG is not checked as it is derived from
CONFIG_64BIT and therefore breaks for the compat vDSO. See the similar,
deactivated check above.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/bitsperlong.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/asm-generic/bitsperlong.h b/include/asm-generic/bitsperlong.h
index 1023e2a4bd37..90e8aeebfd2f 100644
--- a/include/asm-generic/bitsperlong.h
+++ b/include/asm-generic/bitsperlong.h
@@ -19,6 +19,15 @@
 #error Inconsistent word size. Check asm/bitsperlong.h
 #endif
 
+#if __CHAR_BIT__ * __SIZEOF_LONG__ != __BITS_PER_LONG
+#error Inconsistent word size. Check asm/bitsperlong.h
+#endif
+
+#ifndef __ASSEMBLER__
+_Static_assert(sizeof(long) * 8 == __BITS_PER_LONG,
+	       "Inconsistent word size. Check asm/bitsperlong.h");
+#endif
+
 #ifndef BITS_PER_LONG_LONG
 #define BITS_PER_LONG_LONG 64
 #endif

-- 
2.53.0


