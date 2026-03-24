Return-Path: <linux-s390+bounces-17968-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6F41BoC+wmmjlQQAu9opvQ
	(envelope-from <linux-s390+bounces-17968-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 24 Mar 2026 17:40:32 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8067A31930D
	for <lists+linux-s390@lfdr.de>; Tue, 24 Mar 2026 17:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B75630565DB
	for <lists+linux-s390@lfdr.de>; Tue, 24 Mar 2026 16:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906D438E5F6;
	Tue, 24 Mar 2026 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ac5ITu1U"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFA01DE8AF;
	Tue, 24 Mar 2026 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774370072; cv=none; b=XSzonSRB+TxLoCqPjExyKFoqj+m0yDSz//9YQXz9FmRQH0cIeFcJ6GQQTT/hjZ1+2c8Knw3KCAJNbyUKW7Eh3n7ocDf57WSJfgtFQzqAIrJO24AFyRUZKUVSYn4a1K+5yOdUl3n3n/+NPunni10AAYriDmCteKY3bmq6ZPtxB+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774370072; c=relaxed/simple;
	bh=jK2cqe9zEERt7XTSL+IOAhVG8tvgAjujNDCKQTLklwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tpWuNOGLWzBRWmwhVenxZB6lcTLrDH9OjDzJ+of9KlLW0cyy5zHxxonGx4nulY6jnCXs1CVQHgxS6JkWQsuyzf0JuZVwOdikVhWLj5f1o/k+OIwzlKujiiixFxosSisg0gtceY3UH4B00ca3MWvpSnEa0qv3yGkwMHfDMZu0Jdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ac5ITu1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5E0C19424;
	Tue, 24 Mar 2026 16:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774370072;
	bh=jK2cqe9zEERt7XTSL+IOAhVG8tvgAjujNDCKQTLklwU=;
	h=From:To:Cc:Subject:Date:From;
	b=ac5ITu1UCTMLoDOgd2pZOthuTCP5N8hE49EptZbmlm+ePTABD4xe3/7DFyEl4ZuhK
	 XEx4ExZ3HJVMNrR4qdvtIHbU/2N7nCW5e7YLRHiDfJ3QDsYPNXE3F3E1oCobICQFwQ
	 ewtzM8mL9CS0C9oRtmSVsHTdsWHYNlHumql9mFPU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	stable <stable@kernel.org>
Subject: [PATCH] s390/syscalls: add spectre boundry for syscall dispatch table
Date: Tue, 24 Mar 2026 17:34:05 +0100
Message-ID: <2026032404-sterling-swoosh-43e6@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 48
X-Developer-Signature: v=1; a=openpgp-sha256; l=1644; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=jK2cqe9zEERt7XTSL+IOAhVG8tvgAjujNDCKQTLklwU=; b=owGbwMvMwCRo6H6F97bub03G02pJDJmH9vzNyWoO3BRzSHtd1aP1Tm31faudz7ocd1t76tsLg XmGbw/EdcSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBEzFUY5vu6Csh/PMhS9ra6 NETl3rLI/oNbFRnmVyc9itQ+ubVzfm3XbeNlr/muNj65DgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17968-lists,linux-s390=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 8067A31930D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The s390 syscall number is directly controlled by userspace, but does
not have a array_index_nospec() boundry to prevent access past the
syscall function pointer tables.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
My scripts caught this as I think s390 is vulnerable to the old-style
Spectre 1 issues, but I couldn't find where it was addressed in the
syscall path.  Did I just miss it somewhere, or is this patch still
needed?

 arch/s390/kernel/syscall.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/syscall.c b/arch/s390/kernel/syscall.c
index 795b6cca74c9..d103c853e120 100644
--- a/arch/s390/kernel/syscall.c
+++ b/arch/s390/kernel/syscall.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/cpufeature.h>
+#include <linux/nospec.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
@@ -131,8 +132,10 @@ void noinstr __do_syscall(struct pt_regs *regs, int per_trap)
 	if (unlikely(test_and_clear_pt_regs_flag(regs, PIF_SYSCALL_RET_SET)))
 		goto out;
 	regs->gprs[2] = -ENOSYS;
-	if (likely(nr < NR_syscalls))
+	if (likely(nr < NR_syscalls)) {
+		nr = array_index_nospec(nr, NR_syscalls);
 		regs->gprs[2] = sys_call_table[nr](regs);
+	}
 out:
 	syscall_exit_to_user_mode(regs);
 }
-- 
2.53.0


