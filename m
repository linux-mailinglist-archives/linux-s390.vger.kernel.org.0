Return-Path: <linux-s390+bounces-22274-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vM3NEcZJVmqX2wAAu9opvQ
	(envelope-from <linux-s390+bounces-22274-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 16:37:58 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E8A755EF3
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 16:37:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=fqZ6Rgph;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22274-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-22274-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 951A630C81A5
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 14:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DD747F2E8;
	Tue, 14 Jul 2026 14:30:24 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB1047ECD6
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 14:30:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039424; cv=none; b=rSXLqapVBcWxY10QBBRO/J31A7RDjYAbNjKgO3u4WsrQIlS33znHwjOYuDqVNLWAkpWtsf/X+4xmXcdMhRSdwD5TJ1AJ6KSHF3Tvl9NkeRkEKkfByQktyFC7MQd68BHdlgQPh2ZIJlrqLbQWo8OmCJ/fdstjgpdHuXF0ux158/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039424; c=relaxed/simple;
	bh=zFeWDdafDoYi7ea+8KDHKiNyfn2RCWSEnlN5ywMFr9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qRwkp8Pfuibi/zcgOcSph5G2Nso0pqR8p5MaEZ4fxd7fhOIfb6JUc5yU5JeujgEFqJTIKTZv96fR6wus3KWv+FCBletcncWfbAjQakzgJd0u2wh6rtJmm4VKR6+MZifkEB8bSEducPyiuFrFVK+9YVoBgGkgLMILWp7/L17mLUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=fqZ6Rgph; arc=none smtp.client-ip=209.85.167.47
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aeae350e0aso5043785e87.1
        for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 07:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784039420; x=1784644220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=myAuJMzKK/4iG9Cmnf7VPvLoMfqifqNKwX3ebA7nias=;
        b=fqZ6Rgphmp6BfB1w3zQfLmRui03bV4pkN21UgZ8ba5Gcn1E10qX919G0ei3ilz0vOL
         yjrfDDypdVHXPgxRRGPSLzNySRnqryAZl4sQNNFNo1XWXKs3M2/iTaRsYl9rtqeVuQlw
         aeOqsAnJBNv6qDiuKHkJJaxQzqdknxGgmYoSglXffqwf4LsguOXRdQC0UQ9i3Sm8sCbP
         HFrOeq3bdbjAsXd2WDs8+Xz6m7tykP9OD9Zb6QJU+cxN0OtuDK1DRr2YGYOlTt+zD3M4
         dm18+Qdy4iEm7ZsIwvi6xmdis4jmF4CJGyxqHBO8QyUXFcsryoQxRzNmhCy6Kpyy4fsl
         4olg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784039420; x=1784644220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=myAuJMzKK/4iG9Cmnf7VPvLoMfqifqNKwX3ebA7nias=;
        b=WU62JKuyiYFvPN4WPjqMNSwPYfRmO9p1zWzc/RPFzfR5Pyvg2NP0vv19CdqFyqFbXS
         XedjaK1SzLG3Y0Fftoo90fx7BiR5sBPHIIlaUVWZL6upXYSoWmbIRY+Q6jb7WjY1zwsa
         Vj6lKNKiNuB6exRRufSVhMVlnUjw22audjPULdCMSdnz5AJmw40nRbLYjtYF7OSF472/
         VxUlGzlaX/hNkBOco+j9XIZWOGkbBzFSq59+Y3aFbCyqKBGgRqCwYs/3aIJZjXpanIzH
         YQZp9cLqGdrafL5M2fAiWbrz2fP+Mh1+6/qwnWzjFYaChtR+rcJ0AOQLCocHu4SQ6EcQ
         +f0w==
X-Forwarded-Encrypted: i=1; AHgh+RqQZ1sDxvGhTLLkKiITq6xb57Xa8YM2jqSjAJPfmiepwUyHUjhPhVULuHyGqEX7E8MxZE9pyE5XqRpE@vger.kernel.org
X-Gm-Message-State: AOJu0YwuBMBDHEdZpRh+UrPf0GA/QQL/AF46wnpoSLhQnIlyDJyXkAW0
	40Nv0VXeBIhquBfLzjsIxNBQgQ/GDoC2EUjMfNhbvqxOo0eygDAluncRnpJqGaWCD+0=
X-Gm-Gg: AfdE7cn3Ji5Wm39PsuNUniW0ZNMZdktHdRMA3JGhzaDYcIaPtHtNvWQ5+NIoZKuIy6S
	gI2Gdjt8xXpp6htHjcD9UFpiORghZNzjsODr4Wy+D+61Lry0kiUly5Vc0nUpXpOPF1BO9cDUghN
	0yh11c3NUfwSCKbZtMJMBiNk+U+KHHuJkC/3wbZtfD15sD01+jZg1Fy632pWMtgLpihRXFfMxhY
	staB+WZGA7W4/TCT/Zxfr0JoAmm3pjFSkyg0SLX9F8E+zeb9s7jr7bGPW0KMKEsWBWB9DzCkY/O
	lSls1GyoY7madpKeMl1EoUJ72lJ01eV1wqQvvl0L6rTxUc3MMNUOISrgKkT7ObY4dQIq/twopa3
	PSVe/XGSic23SxkKPTzsKuhFHhTflJsVxMM+E+PG0c6wRt+6uBxmU7fqDxrW8xQD/N/9ZhAQWof
	nvAm5mQsj2x91nqIT0QeUH4w==
X-Received: by 2002:a05:6512:21d:b0:5b0:1428:cab9 with SMTP id 2adb3069b0e04-5b0236bb426mr2001205e87.50.1784039419732;
        Tue, 14 Jul 2026 07:30:19 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca4f90csm3589518e87.21.2026.07.14.07.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:30:19 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: cgroups@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	jgg@ziepe.ca,
	leon@kernel.org,
	parav@nvidia.com,
	mbloch@nvidia.com,
	cmeiohas@nvidia.com,
	roman.gushchin@linux.dev,
	bvanassche@acm.org,
	zyjzyj2000@gmail.com,
	shuah@kernel.org,
	tj@kernel.org,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	yanjun.zhu@linux.dev,
	cui.tao@linux.dev
Subject: [PATCH rdma-next v2 12/14] RDMA/rxe: Allow queue VMAs to outlive ucontexts
Date: Tue, 14 Jul 2026 16:29:25 +0200
Message-ID: <20260714142927.1298897-13-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714142927.1298897-1-jiri@resnulli.us>
References: <20260714142927.1298897-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22274-lists,linux-s390=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,kernel.org,nvidia.com,linux.dev,acm.org,gmail.com,suse.com,cmpxchg.org,linux.alibaba.com,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:cgroups@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:parav@nvidia.com,m:mbloch@nvidia.com,m:cmeiohas@nvidia.com,m:roman.gushchin@linux.dev,m:bvanassche@acm.org,m:zyjzyj2000@gmail.com,m:shuah@kernel.org,m:tj@kernel.org,m:mkoutny@suse.com,m:hannes@cmpxchg.org,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:yanjun.zhu@linux.dev,m:cui.tao@linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiri@resnulli.us,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,resnulli.us:from_mime,resnulli.us:mid,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6E8A755EF3

From: Jiri Pirko <jiri@nvidia.com>

Prepare queue mappings for asynchronous ucontext disassociation during
device disable. Rely on the VMA page references to preserve mapped
memory until the final unmap.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- new patch
---
 drivers/infiniband/sw/rxe/rxe_mmap.c | 35 ++--------------------------
 1 file changed, 2 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mmap.c b/drivers/infiniband/sw/rxe/rxe_mmap.c
index 7f723a2f3700..a4ead89ccbd3 100644
--- a/drivers/infiniband/sw/rxe/rxe_mmap.c
+++ b/drivers/infiniband/sw/rxe/rxe_mmap.c
@@ -11,7 +11,6 @@
 
 #include "rxe.h"
 #include "rxe_loc.h"
-#include "rxe_queue.h"
 
 void rxe_mmap_release(struct kref *ref)
 {
@@ -30,29 +29,6 @@ void rxe_mmap_release(struct kref *ref)
 	kfree(ip);
 }
 
-/*
- * open and close keep track of how many times the memory region is mapped,
- * to avoid releasing it.
- */
-static void rxe_vma_open(struct vm_area_struct *vma)
-{
-	struct rxe_mmap_info *ip = vma->vm_private_data;
-
-	kref_get(&ip->ref);
-}
-
-static void rxe_vma_close(struct vm_area_struct *vma)
-{
-	struct rxe_mmap_info *ip = vma->vm_private_data;
-
-	kref_put(&ip->ref, rxe_mmap_release);
-}
-
-static const struct vm_operations_struct rxe_vm_ops = {
-	.open = rxe_vma_open,
-	.close = rxe_vma_close,
-};
-
 /**
  * rxe_mmap - create a new mmap region
  * @context: the IB user context of the process making the mmap() call
@@ -106,17 +82,10 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 	list_del_init(&ip->pending_mmaps);
 	spin_unlock_bh(&rxe->pending_lock);
 
-	vma->vm_ops = &rxe_vm_ops;
-	vma->vm_private_data = ip;
-
 	ret = remap_vmalloc_range(vma, ip->obj, 0);
-	if (ret) {
-		vma->vm_private_data = NULL;
-		vma->vm_ops = NULL;
-		kref_put(&ip->ref, rxe_mmap_release);
+	kref_put(&ip->ref, rxe_mmap_release);
+	if (ret)
 		rxe_dbg_dev(rxe, "err %d from remap_vmalloc_range\n", ret);
-		goto done;
-	}
 
 done:
 	return ret;
-- 
2.54.0


