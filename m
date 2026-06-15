Return-Path: <linux-s390+bounces-20865-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XxuZMtAlMGqdOwUAu9opvQ
	(envelope-from <linux-s390+bounces-20865-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 18:18:24 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2AF68840A
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 18:18:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="ncLsD/vW";
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20865-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-20865-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A83930D3B4E
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 16:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB22C410D2D;
	Mon, 15 Jun 2026 16:10:50 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D4040913C;
	Mon, 15 Jun 2026 16:10:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781539850; cv=none; b=QMwoYsw5L/VEAn2wG2Qa2c/JrmD1sJZe3eR+wkRKjXzgupyTT7TQGWsODSalK++8QragiKtfuUauh58D9wLDcMyUNuyGyuwsr9qPPAqAaIzplkGNR2kaA+pZ95P9tFfP1jZj0AL7qbwZPvx5HBpwY3J2zd8kYhwbWMVh9qJBDLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781539850; c=relaxed/simple;
	bh=pGGyh2TRFwNAqUaNVPHy3MdxdEXBcZz1ASOfsY2J0hU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mnoZsD+hJXzsM1uAshQae2d/X557syBVA0pF/2p6W95WGG4DxGJZCuM0crqu7G1uSOEGQQX8gz9ESJdJfOlj70pLHEbwfmDJxy/NEy0y6WkyB+z7I1jfFzP0CKQ0xQCVM5CggAOUER6IFW7k6BY7tcVEFaDzoRfo4dlgea+ZGAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncLsD/vW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A971F000E9;
	Mon, 15 Jun 2026 16:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781539849;
	bh=lFxkCMBfVV3FCRRMIo+bBBEG8tTSxaqkdb7xuvcsV4E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ncLsD/vWptoJUo1ITW0lSHHZTP2t1jFEPCgv+CTUd42u/OmeM6lJ2bvGv/O2cguq/
	 CGRVS+fQrV+ar2Dep2OqgxJGfaZb/u8VsZa3u3S1sYb5LxUDRAYgkk9yHZ3HbgLW8D
	 hN7dHzVTxwwfwBmjSo2anFbJEMEw/z9vnC7/1IMQl8nlKuJJFyCsq5uKANHsNyPr82
	 g3RuFX94bHb3kaiXw2kU3R+KxyuSepsnY8gGVuuMfvQsnZHtU3+XkENGhZiuDGSfWI
	 Pmc3cW0zvvtQqyxSc6OuWgej1RK+iBlO7UmLdgN8dwmIPLTZA155+Fg8KmHxQA13T5
	 ltKQBxyPSAsLg==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Mon, 15 Jun 2026 18:09:07 +0200
Subject: [PATCH 11/19] s390: define DPS root partition type UUIDs
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-discoverable-root_partitions-v1-11-39c78fac42e2@kernel.org>
References: <20260615-discoverable-root_partitions-v1-0-39c78fac42e2@kernel.org>
In-Reply-To: <20260615-discoverable-root_partitions-v1-0-39c78fac42e2@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Davidlohr Bueso <dave@stgolabs.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-efi@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1915; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=pGGyh2TRFwNAqUaNVPHy3MdxdEXBcZz1ASOfsY2J0hU=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDFkGylfLshtvnHJ7dCT+Qb6LaOoZ2cSaSGWeDZO36e04H
 lG3IYSzYyILgxgXg6WYIsuyck5uhY5C77BDfy1h5rAygQyRFmlgAAIWBr7cxLxSIx0jPVNtQz1D
 IEPHiIGLUwCmWp2PkWHe/f23jm29Zx09SfrVUYHpPHJnpG+4W3zP3do6a7mA0V5LRobOPc+Z101
 rrNpbYNj6z6D1wbdnXgFyX5UVrU71F3Hc3MYKAA==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:dave@stgolabs.net,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:linux-kernel@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-efi@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:mailhol@kernel.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:linux-s390@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[mailhol@kernel.org,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-20865-lists,linux-s390=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailhol@kernel.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,uapi-group.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F2AF68840A

DPS [1] assigns GPT partition type UUIDs to operating system partitions.
Root partitions use architecture-specific type UUIDs so the OS can
discover the intended root filesystem without relying on a root= cmdline
option.

Define DPS_ROOT_PARTITION_TYPE_UUID in asm/dps_root.h for the s390
(32-bit) and s390x (64-bit) variants described by the specification and
select ARCH_HAS_DPS_ROOT_PARTITION_TYPE_UUID.

[1] The Discoverable Partitions Specification (DPS)
Link: https://uapi-group.org/specifications/specs/discoverable_partitions_specification/

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 arch/s390/Kconfig                |  1 +
 arch/s390/include/asm/dps_root.h | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 9921a3772bf7..af2cf67fffd7 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -91,6 +91,7 @@ config S390
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_DMA_OPS if PCI
+	select ARCH_HAS_DPS_ROOT_PARTITION_TYPE_UUID
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	select ARCH_HAS_FORTIFY_SOURCE
diff --git a/arch/s390/include/asm/dps_root.h b/arch/s390/include/asm/dps_root.h
new file mode 100644
index 000000000000..e72e44a66097
--- /dev/null
+++ b/arch/s390/include/asm/dps_root.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _ASM_S390_DPS_ROOT_H
+#define _ASM_S390_DPS_ROOT_H
+
+#ifdef CONFIG_64BIT
+#define DPS_ROOT_PARTITION_TYPE_UUID "5eead9a9-fe09-4a1e-a1d7-520d00531306"
+#else
+#define DPS_ROOT_PARTITION_TYPE_UUID "08a7acea-624c-4a20-91e8-6e0fa67d23f9"
+#endif
+
+#endif /* _ASM_S390_DPS_ROOT_H */

-- 
2.53.0


