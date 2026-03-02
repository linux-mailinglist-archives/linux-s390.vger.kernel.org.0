Return-Path: <linux-s390+bounces-16673-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPWUIG1DpWkg7AUAu9opvQ
	(envelope-from <linux-s390+bounces-16673-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 02 Mar 2026 08:59:41 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9EE1D447F
	for <lists+linux-s390@lfdr.de>; Mon, 02 Mar 2026 08:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C500C302DE35
	for <lists+linux-s390@lfdr.de>; Mon,  2 Mar 2026 07:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D418B3876BB;
	Mon,  2 Mar 2026 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HLcwMe71";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P+DKLgDO"
X-Original-To: linux-s390@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B17B3859FD;
	Mon,  2 Mar 2026 07:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772438334; cv=none; b=Wf84wQgXZKhyclmU0qfqFIiiJk2a8GgIfUVYBAsn2eGWCHK25PCZcW6ofiyTPNUpbfTHEXFS1w9JTWjxyE9iiJseAhVrI/PanyFKqKPghLxAEV8NsMCibIJcCEJJjTPI7MZNmFdIqOC3ws15zWBotQIhT/GSwC6x7o3mQBHX7do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772438334; c=relaxed/simple;
	bh=CVSp9N7ojydH+g55wpL0oEQy1NPWvz/8vcri2dbmViY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sxL1o7jwMui/ePuy1568JCB8nHMN3GWxbovj0KIsGoGeSNQFOrwv/q5VTflLWgU6cPIV9RXnibwqSE9cjO+p9HYWq6SmICqdH2teOYG67+25QJ4lVSOy1OHs5tYAkQVo5w2krPYP/2kPMCy6AqxIK2f8GdP8lx+BukvF+iiLWPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HLcwMe71; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P+DKLgDO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772438332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8mcgepFI0mjBE0CWOdrG5t6m+R1W63RB4CuAREY+63Q=;
	b=HLcwMe71m9ympi7l8ojF719Wk0h5dn83FMfTV2eQj+BsIGnoLt//wF957nA94RMrcQ+cmP
	qEC5Fp6Iyck1YtuGVOrktMAZlKQHS9yEcLQmo/0wcN7rgByvJbjRgbQRJ4C26cNL0Kf0gN
	eGssvjqFfCb3b0h3edf16P2CoW1NLM2vfN5yicNUdGT5MB0EDEDaXA6ZMY0MagK3NbS6BC
	9QdfYfxeKl1IcOkuSxQNEGL2+uvVZJWE7va6DfdZnxVpiYTRSienFC/jT5xg8PPopE+j7j
	Xig5KOwPNRDG9jfz2/lrP/9iUFo5fA9iSHIPhf6qj6eAMfPdiLjACBWXGcsq0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772438332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8mcgepFI0mjBE0CWOdrG5t6m+R1W63RB4CuAREY+63Q=;
	b=P+DKLgDOi3dnOL/kQA6aCgkM34iRMwcaE2eHH/CHlKfBv8Ls2GwbOPP9cSN6G7kAkOHhWN
	4m0jvGhZo/3wd4BA==
Date: Mon, 02 Mar 2026 08:58:40 +0100
Subject: [PATCH v2 4/5] powerpc/audit: directly include unistd_32.h from
 compat_audit.c
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260302-vdso-compat-checkflags-v2-4-78e55baa58ba@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772438327; l=1025;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=CVSp9N7ojydH+g55wpL0oEQy1NPWvz/8vcri2dbmViY=;
 b=5UJigRuF1ls39QQ7kYsZuAT52JM94nxcB/HBtSSri5qEB/zHIEP+ctD0UzjErLMR8hzmiHDY+
 asSEu4ht1X7COVSQi1dPSE+PM1nFTj8O0AyRPzX/iKSvzdf9gNJv3ej
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16673-lists,linux-s390=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,gaisler.com,kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,linux.ibm.com,ellerman.id.au,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lists.ozlabs.org,linutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-s390];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim,linutronix.de:email]
X-Rspamd-Queue-Id: EE9EE1D447F
X-Rspamd-Action: no action

This source file undefines '__powerpc64__' to get the 32-bit system call
numbers from asm/unistd.h. However this symbol is also evaluated by
other headers, among them is asm/bitsperlong.h. The undefinition leads
to an inconsistency between __BITS_PER_LONG and the C type 'long'.
An upcoming consistency check will be tripped by this.

Directly include asm/unistd_32.h to get access to the 32-bit system call
numbers instead.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/powerpc/kernel/compat_audit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/compat_audit.c b/arch/powerpc/kernel/compat_audit.c
index 57b38c592b9f..b4d81a57b2d9 100644
--- a/arch/powerpc/kernel/compat_audit.c
+++ b/arch/powerpc/kernel/compat_audit.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
-#undef __powerpc64__
 #include <linux/audit_arch.h>
-#include <asm/unistd.h>
+#include <asm/unistd_32.h>
 
 #include "audit_32.h"
 

-- 
2.53.0


