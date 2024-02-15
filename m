Return-Path: <linux-s390+bounces-1823-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBB48567A8
	for <lists+linux-s390@lfdr.de>; Thu, 15 Feb 2024 16:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF801C244C9
	for <lists+linux-s390@lfdr.de>; Thu, 15 Feb 2024 15:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A311339BD;
	Thu, 15 Feb 2024 15:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b="R6SABlyO"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB137133439;
	Thu, 15 Feb 2024 15:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.215.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011035; cv=none; b=Y7JmPw/MkDvocQowXwfS8ot5MKEz6q2YWWMmzkL9lTpRnLyPZA4FPpBTMUuEnTBCudXl7t4xF7dFwUorJOUWTiI9i40hfa+X97vHrbnkYc5ChyZCgkPvZS7MC/cLilkjDX+i0EOmik6e3AFP+zh31e6k3vimsvQl/siRQpEDCBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011035; c=relaxed/simple;
	bh=Gjh7KJhrYjooGejRnZYLbWryu6U81mbFlCjbGUevu7k=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rxOtF+1yv6KjaxpNSeWmzj7/2906U4VuRUb8d551AhVlzpm/3W2VlibSmxgp+q0Wo+LSagIQuZ/uYVAUq5ZnbZEBigZinqETU4g6m5K484B1aRUQ4s39++4GcxGxfk1efRbhsbyAWd1gghHKuUlKifi2FBmHGb2cz+57JCApXJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org; spf=pass smtp.mailfrom=xen.org; dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b=R6SABlyO; arc=none smtp.client-ip=104.130.215.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
	s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:To:From;
	bh=dgg90eY5E+PlYWhnmyGMGapEm6KwHKu4vEv19gqCPLo=; b=R6SABlyOYDCcI7WdYVjD8zW0zg
	Mgct0KIHxF04fvoHoDoAv7J9JHQjKIF5Qj4ykX1Tel7BWJt2gZHDVlL/O3APTkj352N6cjQhPrV7S
	3Bjr8kCunaEB68GLNH+sWl2HTQiG8Q2banvc4O0NEhqIL86gNCiCbrx2rkNOeOhpP3M0=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1radgn-0001EK-JP; Thu, 15 Feb 2024 15:30:17 +0000
Received: from 54-240-197-226.amazon.com ([54.240.197.226] helo=REM-PW02S00X.ant.amazon.com)
	by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1radgn-00089r-AZ; Thu, 15 Feb 2024 15:30:17 +0000
From: Paul Durrant <paul@xen.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Paul Durrant <paul@xen.org>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v13 04/21] KVM: pfncache: add a mark-dirty helper
Date: Thu, 15 Feb 2024 15:28:59 +0000
Message-Id: <20240215152916.1158-5-paul@xen.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215152916.1158-1-paul@xen.org>
References: <20240215152916.1158-1-paul@xen.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Durrant <pdurrant@amazon.com>

At the moment pages are marked dirty by open-coded calls to
mark_page_dirty_in_slot(), directly deferefencing the gpa and memslot
from the cache. After a subsequent patch these may not always be set
so add a helper now so that caller will protected from the need to know
about this detail.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
---
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org

v13:
 - s/kvm_gpc_mark_dirty/kvm_gpc_mark_dirty_in_slot
 - Add a check for a NULL memslot pointer

v8:
 - Make the helper a static inline.
---
 arch/x86/kvm/x86.c       |  2 +-
 arch/x86/kvm/xen.c       |  6 +++---
 include/linux/kvm_host.h | 13 +++++++++++++
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b66c45e7f6f8..16269430006f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3151,7 +3151,7 @@ static void kvm_setup_guest_pvclock(struct kvm_vcpu *v,
 
 	guest_hv_clock->version = ++vcpu->hv_clock.version;
 
-	mark_page_dirty_in_slot(v->kvm, gpc->memslot, gpc->gpa >> PAGE_SHIFT);
+	kvm_gpc_mark_dirty_in_slot(gpc);
 	read_unlock_irqrestore(&gpc->lock, flags);
 
 	trace_kvm_pvclock_update(v->vcpu_id, &vcpu->hv_clock);
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index f3327508ae41..2d001a9c6378 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -453,11 +453,11 @@ static void kvm_xen_update_runstate_guest(struct kvm_vcpu *v, bool atomic)
 	}
 
 	if (user_len2) {
-		mark_page_dirty_in_slot(v->kvm, gpc2->memslot, gpc2->gpa >> PAGE_SHIFT);
+		kvm_gpc_mark_dirty_in_slot(gpc2);
 		read_unlock(&gpc2->lock);
 	}
 
-	mark_page_dirty_in_slot(v->kvm, gpc1->memslot, gpc1->gpa >> PAGE_SHIFT);
+	kvm_gpc_mark_dirty_in_slot(gpc1);
 	read_unlock_irqrestore(&gpc1->lock, flags);
 }
 
@@ -565,7 +565,7 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 		WRITE_ONCE(vi->evtchn_upcall_pending, 1);
 	}
 
-	mark_page_dirty_in_slot(v->kvm, gpc->memslot, gpc->gpa >> PAGE_SHIFT);
+	kvm_gpc_mark_dirty_in_slot(gpc);
 	read_unlock_irqrestore(&gpc->lock, flags);
 
 	/* For the per-vCPU lapic vector, deliver it as MSI. */
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index bbfefd7e612f..5a27b4389d32 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1398,6 +1398,19 @@ int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len);
  */
 void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc);
 
+/**
+ * kvm_gpc_mark_dirty_in_slot - mark a cached guest page as dirty.
+ *
+ * @gpc:	   struct gfn_to_pfn_cache object.
+ */
+static inline void kvm_gpc_mark_dirty_in_slot(struct gfn_to_pfn_cache *gpc)
+{
+	lockdep_assert_held(&gpc->lock);
+	if (gpc->memslot)
+		mark_page_dirty_in_slot(gpc->kvm, gpc->memslot,
+					gpc->gpa >> PAGE_SHIFT);
+}
+
 void kvm_sigset_activate(struct kvm_vcpu *vcpu);
 void kvm_sigset_deactivate(struct kvm_vcpu *vcpu);
 
-- 
2.39.2


