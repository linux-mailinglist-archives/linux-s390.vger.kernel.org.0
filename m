Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B96346610E
	for <lists+linux-s390@lfdr.de>; Thu,  2 Dec 2021 10:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241531AbhLBKDI (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 2 Dec 2021 05:03:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:27566 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241259AbhLBKCZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 Dec 2021 05:02:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638439142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OgwYURLKfRsAm9+GAZglDNSkPIsZcRJ6yZviZEoxLLU=;
        b=TQ4cEooXwRmBX5E2uiJ7YegpT7pTgRl6Tgc4QSNqZcyITri69c4q+y5KMkAw7NGOZbSuE8
        qKL/N4bjYvuyx33g73X/fZ5VSaCbwj9RdT0/Nl/w4h2Fh7zGWpMnN82k5ZOJhzmJSmU30w
        FWlq3FP3CO+0rV1mJk7bjRStHhmq2vI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-nwCTtHLnNTWVfjQiDuKGOw-1; Thu, 02 Dec 2021 04:58:59 -0500
X-MC-Unique: nwCTtHLnNTWVfjQiDuKGOw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAE10802925;
        Thu,  2 Dec 2021 09:58:57 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48FBF5D9CA;
        Thu,  2 Dec 2021 09:58:44 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Thomas Huth <thuth@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sebastian Mitterle <smitterl@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: [kvm-unit-tests PATCH v1 0/2] s390x: firq: floating interrupt test
Date:   Thu,  2 Dec 2021 10:58:41 +0100
Message-Id: <20211202095843.41162-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From patch #2:

"
We had a KVM BUG fixed by kernel commit a3e03bc1368c ("KVM: s390: index
kvm->arch.idle_mask by vcpu_idx"), whereby a floating interrupt might get
stuck forever because a CPU in the wait state would not get woken up.

The issue can be triggered when CPUs are created in a nonlinear fashion,
such that the CPU address ("core-id") and the KVM cpu id don't match.

So let's start with a floating interrupt test that will trigger a
floating interrupt (via SCLP) to be delivered to a CPU in the wait state.
"

David Hildenbrand (2):
  s390x: make smp_cpu_setup() return 0 on success
  s390x: firq: floating interrupt test

 lib/s390x/smp.c     |   1 +
 s390x/Makefile      |   1 +
 s390x/firq.c        | 141 ++++++++++++++++++++++++++++++++++++++++++++
 s390x/unittests.cfg |  10 ++++
 4 files changed, 153 insertions(+)
 create mode 100644 s390x/firq.c

-- 
2.31.1

