Return-Path: <linux-s390+bounces-16711-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKX/N/KQpWmoDgYAu9opvQ
	(envelope-from <linux-s390+bounces-16711-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 02 Mar 2026 14:30:26 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0381D9C7F
	for <lists+linux-s390@lfdr.de>; Mon, 02 Mar 2026 14:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A040C3010494
	for <lists+linux-s390@lfdr.de>; Mon,  2 Mar 2026 13:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D04D3EF0A0;
	Mon,  2 Mar 2026 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="RaIJo34Y"
X-Original-To: linux-s390@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2FA3370E3
	for <linux-s390@vger.kernel.org>; Mon,  2 Mar 2026 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458124; cv=none; b=E+ozYLY/WEI78S/TGheC5ht8qQl7x1C8e5F8bLwoZ4i9wFCoy5qLB9dNfAV21cJw0JxEqwK8DvSPT37gyHtU9sN9PEL2b6bbxr2+7DzfPJ2jEiN9yt/d0SrahGHmE/eIMtnvPH8X1JKlTpxxwXKu+r5CGfXFNDAZfciOHQvuJfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458124; c=relaxed/simple;
	bh=FKFw9WDEltFsWTOOSmYNAvvnsX/tHlWIyPea6wX7cZU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RHpNilmi1eCKfYc2mgtMQfvXx4OGy0sOOgkk2vI0jPPax155y0/0CBgjiaTEYOmpNAIqeDycYEwu2kiOuGGZ8u29qGft0BZKG3GUI0gAVG5sQrV2nIcfayf6Vm0pLEeLcwY4rMlOV3pC6g6aLxrm2SEYsn+GDsBb2k5i50cFB+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=RaIJo34Y; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vx3Jx-003ZEJ-9O; Mon, 02 Mar 2026 14:28:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:To:From;
	bh=o2ClYLRupqDrO68wbhPYoX/KO8vhOPlwFWoOd/NbY3w=; b=RaIJo34Y0Q7j2egm9oaHOlOtOd
	qIf5fI6+l/d2wpNaqq8G9dXTQ9MMLD3B96RqcrmcIuZWAbHSJrVvAOsCyxNnHmB0ApiOwjvIA/WUq
	2QHmlroveisu5RbpBCARdjIwFelcSMWSgnuhcGGnezIcVvrdSc/czwp60dIuZ0dJ0UBhYTt3Dir6A
	kPjMxT6Sx+w5jzEelLAoWpF5WZwr5068t7N9pLbu3BuEHsUXyhRpZNDULOe1NTcLEJsTarSsqPA3q
	jO3BiP4+6U4spuDiRYWorjNHk7ZXXdxC/8mJTlzMjB17nS6wB8o7mn+sdiXsOXXocQv+tO32ThUWi
	FRs2OCew==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vx3Jw-0001hU-9m; Mon, 02 Mar 2026 14:28:24 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vx3Jj-008UTR-SY; Mon, 02 Mar 2026 14:28:11 +0100
From: david.laight.linux@gmail.com
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Andre Almeida <andrealmeid@igalia.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Darren Hart <dvhart@infradead.org>,
	David Laight <david.laight.linux@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Heiko Carstens <hca@linux.ibm.com>,
	Jan Kara <jack@suse.cz>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org,
	Kees Cook <kees@kernel.org>,
	akpm@linux-foundation.org
Subject: [PATCH v2 4/5] uaccess: Disable -Wshadow in __scoped_user_access()
Date: Mon,  2 Mar 2026 13:27:54 +0000
Message-Id: <20260302132755.1475451-5-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302132755.1475451-1-david.laight.linux@gmail.com>
References: <20260302132755.1475451-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[runbox.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16711-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,igalia.com,citrix.com,linux.ibm.com,kernel.org,csgroup.eu,infradead.org,gmail.com,stgolabs.net,suse.cz,inria.fr,linux-foundation.org,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,efficios.com,ellerman.id.au,imag.fr,dabbelt.com,armlinux.org.uk,linutronix.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	DKIM_TRACE(0.00)[runbox.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-s390];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[runbox.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E0381D9C7F
X-Rspamd-Action: no action

From: David Laight <david.laight.linux@gmail.com>

-Wshadow is enabled by W=2 builds and __scoped_user_access() quite
deliberately creates a 'const' shadow of the 'user' address that
references a 'guard page' when the application passes a kernel pointer.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/uaccess.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 64bc2492eb99..445391ec5a6d 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -739,7 +739,9 @@ static __always_inline void __scoped_user_rw_access_end(const void *p)
 #define __scoped_user_access(mode, uptr, size, elbl)					\
 	with (auto _tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl))	\
 		/* Force modified pointer usage within the scope */			\
-		and_with (const auto uptr __cleanup(__scoped_user_##mode##_access_end) = _tmpptr)
+		__diag_push() __diag_ignore_all("-Wshadow", "uptr is readonly copy")	\
+		and_with (const auto uptr __cleanup(__scoped_user_##mode##_access_end) = _tmpptr) \
+		__diag_pop()
 
 /**
  * scoped_user_read_access_size - Start a scoped user read access with given size
-- 
2.39.5


