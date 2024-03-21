Return-Path: <linux-s390+bounces-2668-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 757E08862CF
	for <lists+linux-s390@lfdr.de>; Thu, 21 Mar 2024 23:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E2A28491E
	for <lists+linux-s390@lfdr.de>; Thu, 21 Mar 2024 22:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375BC1369B1;
	Thu, 21 Mar 2024 22:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqPPp2MZ"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F51F136676
	for <linux-s390@vger.kernel.org>; Thu, 21 Mar 2024 22:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711058415; cv=none; b=XkVvF9L+xnJNz2qQyucNFO2nIVnr+SFxt/463VwRbPLve6KPK+bKfv8ihl/JvwXDBO1JMCLDNy51xKWjvkdWOWOG4SNTnL1YN0UAooljOe0vPcTHeDooArabU9jZBvy2UjMNW+/1V4fIpUnIhBxakSsV1gtg4WZ34J8H8FaLySQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711058415; c=relaxed/simple;
	bh=MUnq4/9M9vqTEBi0VBbrZcfbKui9X18koTYZs2S57UU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gJuzmfv9qVGODNmMh86V6MhZnzvJAORvYCdFhY/yA5UQ06j0GX6kiFJuflFJjNzEFISwLdSKyKkhEUCtGi9Ni1TMiuQ1Vg8L5NVLijnQnyGxTE+28SIK3+2osctn3ouvY4Q4PS0JifUvRsVNZxBBINIEZpJ9onK2+T5ZgKGEJv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fqPPp2MZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711058412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nBGES3csgpwp5vpSi4JEYoorjMw2XPXljjFYfhTZHaY=;
	b=fqPPp2MZSeVNj/web/pfAErUv5+dOl6XvGfAq2R9VTzqy9niIAkfcnKHXOsKBCx3CqUKyp
	8Ci3vL31SG21tIRYV3JrE68qcOB+/8v9WLiiJRkdIpLmfyLJRW/0YOQrIforiSk5K6xUCG
	RuD+kSJsxEs8fMnk8n3C1Xk31SG1jUc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-QPBc37aMNa2ekgj5rzr0ow-1; Thu, 21 Mar 2024 18:00:06 -0400
X-MC-Unique: QPBc37aMNa2ekgj5rzr0ow-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28A5E185A781;
	Thu, 21 Mar 2024 22:00:06 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.95])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 91CEC1C060A6;
	Thu, 21 Mar 2024 21:59:59 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	kvm@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: [PATCH v1 0/2] s390/mm: shared zeropage + KVM fix and optimization
Date: Thu, 21 Mar 2024 22:59:52 +0100
Message-ID: <20240321215954.177730-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

This series fixes one issue with uffd + shared zeropages on s390x and
optimizes "ordinary" KVM guests to make use of shared zeropages again.

userfaultfd could currently end up mapping shared zeropages into processes
that forbid shared zeropages. This only apples to s390x, relevant for
handling PV guests and guests that use storage kets correctly. Fix it
by placing a zeroed folio instead of the shared zeropage during
UFFDIO_ZEROPAGE instead.

I stumbled over this issue while looking into a customer scenario that
is using:

(1) Memory ballooning for dynamic resizing. Start a VM with, say, 100 GiB
    and inflate the balloon during boot to 60 GiB. The VM has ~40 GiB
    available and additional memory can be "fake hotplugged" to the VM
    later on demand by deflating the balloon. Actual memory overcommit is
    not desired, so physical memory would only be moved between VMs.

(2) Live migration of VMs between sites to evacuate servers in case of
    emergency.

Without the shared zeropage, during (2), the VM would suddenly consume
100 GiB on the migration source and destination. On the migration source,
where we don't excpect memory overcommit, we could easilt end up crashing
the VM during migration.

Independent of that, memory handed back to the hypervisor using "free page
reporting" would end up consuming actual memory after the migration on the
destination, not getting freed up until reused+freed again.

While there might be ways to optimize parts of this in QEMU, we really
should just support the shared zeropage again for ordinary VMs.

We only expect legcy guests to make use of storage keys, so let's handle
zeropages again when enabling storage keys or when enabling PV. To not
break userfaultfd like we did in the past, don't zap the shared zeropages,
but instead trigger unsharing faults, just like we do for unsharing
KSM pages in break_ksm().

Unsharing faults will simply replace the shared zeropage by a zeroed
anonymous folio. We can already trigger the same fault path using GUP,
when trying to long-term pin a shared zeropage, but also when unmerging
a KSM-placed zeropages, so this is nothing new.

Patch #1 tested on 86-64 by forcing mm_forbids_zeropage() to be 1, and
running the uffd selftests.

Patch #2 tested on s390x: the live migration scenario now works as
expected, and kvm-unit-tests that trigger usage of skeys work well, whereby
I can see detection and unsharing of shared zeropages.

Based on current mm-unstable. Maybe at least the second patch should
go via the s390x tree, I think patch #1 could go that route as well.

Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org

David Hildenbrand (2):
  mm/userfaultfd: don't place zeropages when zeropages are disallowed
  s390/mm: re-enable the shared zeropage for !PV and !skeys KVM guests

 arch/s390/include/asm/gmap.h        |   2 +-
 arch/s390/include/asm/mmu.h         |   5 +
 arch/s390/include/asm/mmu_context.h |   1 +
 arch/s390/include/asm/pgtable.h     |  15 ++-
 arch/s390/kvm/kvm-s390.c            |   4 +-
 arch/s390/mm/gmap.c                 | 163 +++++++++++++++++++++-------
 mm/userfaultfd.c                    |  35 ++++++
 7 files changed, 178 insertions(+), 47 deletions(-)

-- 
2.43.2


