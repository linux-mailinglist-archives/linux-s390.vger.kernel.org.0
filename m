Return-Path: <linux-s390+bounces-19226-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONZ2IIjV8mnIugEAu9opvQ
	(envelope-from <linux-s390+bounces-19226-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 30 Apr 2026 06:07:36 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D2449D320
	for <lists+linux-s390@lfdr.de>; Thu, 30 Apr 2026 06:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D99D304F23F
	for <lists+linux-s390@lfdr.de>; Thu, 30 Apr 2026 04:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C046F35295E;
	Thu, 30 Apr 2026 04:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJyCN/cP"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4D6279917;
	Thu, 30 Apr 2026 04:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777521914; cv=none; b=NaGt5xzQrYigSVXQQu/tSGuyi48o9OuxUUwx5L/oYJUebq01OjQplDHtCTMx/vZWkEzA4d1K+6UyA9+UzB4M7NfkLJk4i+t7JMIkVvdwCszgTiGkFxbgfwRD+YuAGQ7ws4keXgpf2QBKqfjM2s8ki7WaE6Vda3oQizvBqdOKytE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777521914; c=relaxed/simple;
	bh=6MPYWPf1QbIXw7VCTkYtFV9yBQTJYYcQnuchAn2u66s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sSptMJJ8mYU9cM0fEULW5ESudviOS40A5qCVDjKguKsqPunbI0CUiDTCFonWCRu8oBsJqfG5nhtw8Tr2YD9LVTWpco6051uzMnZPj//dj+fk43+kR0F/GJvHfDDsh9NSQJrm78xN86pCngoOH3gnNR7AsNIAEKcyNj7+71+BIx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJyCN/cP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B00CC2BCC6;
	Thu, 30 Apr 2026 04:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777521914;
	bh=6MPYWPf1QbIXw7VCTkYtFV9yBQTJYYcQnuchAn2u66s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uJyCN/cPD0/zuU5TMG/FWh17eVTVcTCG22wyND+Ln22vdCzvScs+KeOLVG9RmOssZ
	 jDw1d8PhCAGGbMI/IFgx4Z5EBNcmkVO03z+9/CJtVz3K4wxUxjDLHuhXQrygfZY0vj
	 Mz9EPYWMtvXMUkv1GvrXcIXqYy7f2Nbz3f61nlophvJmqpD4ikN6UOlFyXJonZi3kU
	 apK9iwjy49sl7fMM6lNjIBPwaa1bmY1pG/z4xtRWqVUh4kt9XKZhnZLwyhRWE61vDF
	 fxzmTVdxergJndpikZIoTxLjBRYHAUamicyvLwT/yqUnIVLaZSAeOqCic0yYJ36c4O
	 EWCGitvEei8LA==
From: "Barry Song (Xiaomi)" <baohua@kernel.org>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	willy@infradead.org
Cc: david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jack@suse.cz,
	pfalcato@suse.de,
	wanglian@kylinos.cn,
	chentao@kylinos.cn,
	lianux.mm@gmail.com,
	kunwu.chan@gmail.com,
	liyangouwen1@oppo.com,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	youngjun.park@lge.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	"Barry Song (Xiaomi)" <baohua@kernel.org>
Subject: [PATCH v2 4/5] mm: Don't retry page fault if folio is uptodate during swap-in
Date: Thu, 30 Apr 2026 12:04:26 +0800
Message-Id: <20260430040427.4672-5-baohua@kernel.org>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260430040427.4672-1-baohua@kernel.org>
References: <20260430040427.4672-1-baohua@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A4D2449D320
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,google.com,suse.com,suse.cz,suse.de,kylinos.cn,gmail.com,oppo.com,tencent.com,huaweicloud.com,redhat.com,lge.com,lists.infradead.org,vger.kernel.org,lists.linux.dev,lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-19226-lists,linux-s390=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baohua@kernel.org,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

If we are waiting for long I/O to complete, it makes sense to
avoid holding locks for too long. However, if the folio is
uptodate, we are likely only waiting for a concurrent PTE
update to finish. Retrying the entire page fault seems
excessive.

Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
---
 mm/memory.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 0c740ca363cc..a2e4f2d87ec8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4949,6 +4949,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	}
 
 	swapcache = folio;
+	/*
+	 * If the folio is uptodate, we are likely only waiting for
+	 * another concurrent PTE mapping to complete, which should
+	 * be brief. No need to drop the lock and retry the fault.
+	 */
+	if (folio_test_uptodate(folio))
+		vmf->flags &= ~FAULT_FLAG_ALLOW_RETRY;
 	ret |= folio_lock_or_retry(folio, vmf);
 	if (ret & VM_FAULT_RETRY) {
 		if (fault_flag_allow_retry_first(vmf->flags) &&
-- 
2.39.3 (Apple Git-146)


