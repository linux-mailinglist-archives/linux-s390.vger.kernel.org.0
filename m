Return-Path: <linux-s390+bounces-1822-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C468567A4
	for <lists+linux-s390@lfdr.de>; Thu, 15 Feb 2024 16:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E891F227D2
	for <lists+linux-s390@lfdr.de>; Thu, 15 Feb 2024 15:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DE21339A0;
	Thu, 15 Feb 2024 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b="nLahtEzG"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0E7133434;
	Thu, 15 Feb 2024 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.215.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011034; cv=none; b=hOBgISp9c6KD4GbicRCOxr1fJyxwMvgWkjaM2frBkz58/Phh/r9ZjF/T1Xd9GDBCU30nWIseh6Z33PUVYHJa12GAtzxJZxe6DhAL2JVKa0IjBsoNms0oQao5BDc6RMjI8fK/KTeqGomej667k3Z372p3j2SZoEreS+bCOhrEzRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011034; c=relaxed/simple;
	bh=X/WsBLnIzIL2tm2hCMFKJpiOFtCtGjkxbwRt5PheKO4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ce3J72Cwj7PWEBIWC/RY8x18QcobcQiNQ7iGqpV7Q7ZVpz/SxAq5V6K12HaUGFPz9EJM4CjSP0fx7n4US+h7DNwUsaIPvWd/u/LVPSbC/aTrYUOCYooRx9G7+Z1inFBXFf0JIXi41uI7gAPxj9lsL6bFDLn3qGzztk7IFGjvQEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org; spf=pass smtp.mailfrom=xen.org; dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b=nLahtEzG; arc=none smtp.client-ip=104.130.215.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
	s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:To:From;
	bh=MzrwEZvE/wDfZ2Uo3THdD0GCfEvkC+DSco4Yj2j2Ijs=; b=nLahtEzG0yR+mQ7BUOJj6qVQHv
	AV/b5Nw+QIpzDU8OGMckPKerSIwlaRHOwwR9at/NjfvOGQWf9DeANfcH0Gqp2mBZMhg1HDeYMMhwR
	h2oDvQuIR6J3vCcPPb1eKWlKsavsKOivMYFN2h+SQy4SVMOYLWgzODJnJQI9J9NG/1WE=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1radgk-0001E7-Av; Thu, 15 Feb 2024 15:30:14 +0000
Received: from 54-240-197-226.amazon.com ([54.240.197.226] helo=REM-PW02S00X.ant.amazon.com)
	by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1radgk-00089r-1T; Thu, 15 Feb 2024 15:30:14 +0000
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
Subject: [PATCH v13 03/21] KVM: x86/xen: mark guest pages dirty with the pfncache lock held
Date: Thu, 15 Feb 2024 15:28:58 +0000
Message-Id: <20240215152916.1158-4-paul@xen.org>
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

Sampling gpa and memslot from an unlocked pfncache may yield inconsistent
values so, since there is no problem with calling mark_page_dirty_in_slot()
with the pfncache lock held, relocate the calls in
kvm_xen_update_runstate_guest() and kvm_xen_inject_pending_events()
accordingly.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
---
Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: x86@kernel.org

v13:
 - Patch title change.

v8:
 - New in this version.
---
 arch/x86/kvm/xen.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 4b4e738c6f1b..f3327508ae41 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -452,14 +452,13 @@ static void kvm_xen_update_runstate_guest(struct kvm_vcpu *v, bool atomic)
 		smp_wmb();
 	}
 
-	if (user_len2)
+	if (user_len2) {
+		mark_page_dirty_in_slot(v->kvm, gpc2->memslot, gpc2->gpa >> PAGE_SHIFT);
 		read_unlock(&gpc2->lock);
-
-	read_unlock_irqrestore(&gpc1->lock, flags);
+	}
 
 	mark_page_dirty_in_slot(v->kvm, gpc1->memslot, gpc1->gpa >> PAGE_SHIFT);
-	if (user_len2)
-		mark_page_dirty_in_slot(v->kvm, gpc2->memslot, gpc2->gpa >> PAGE_SHIFT);
+	read_unlock_irqrestore(&gpc1->lock, flags);
 }
 
 void kvm_xen_update_runstate(struct kvm_vcpu *v, int state)
@@ -565,13 +564,13 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 			     : "0" (evtchn_pending_sel32));
 		WRITE_ONCE(vi->evtchn_upcall_pending, 1);
 	}
+
+	mark_page_dirty_in_slot(v->kvm, gpc->memslot, gpc->gpa >> PAGE_SHIFT);
 	read_unlock_irqrestore(&gpc->lock, flags);
 
 	/* For the per-vCPU lapic vector, deliver it as MSI. */
 	if (v->arch.xen.upcall_vector)
 		kvm_xen_inject_vcpu_vector(v);
-
-	mark_page_dirty_in_slot(v->kvm, gpc->memslot, gpc->gpa >> PAGE_SHIFT);
 }
 
 int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
-- 
2.39.2


