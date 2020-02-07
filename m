Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA7931556E5
	for <lists+linux-s390@lfdr.de>; Fri,  7 Feb 2020 12:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgBGLkT (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 7 Feb 2020 06:40:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31738 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727138AbgBGLkI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 7 Feb 2020 06:40:08 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 017BbaQM131424;
        Fri, 7 Feb 2020 06:40:05 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xyhn55xcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Feb 2020 06:40:05 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 017Be5Lw140058;
        Fri, 7 Feb 2020 06:40:05 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xyhn55xbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Feb 2020 06:40:05 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 017BcsbR015495;
        Fri, 7 Feb 2020 11:40:04 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04wdc.us.ibm.com with ESMTP id 2xykc9vtps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Feb 2020 11:40:04 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 017Be2em46924080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Feb 2020 11:40:02 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 708F1AC05F;
        Fri,  7 Feb 2020 11:40:02 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B73DAC05B;
        Fri,  7 Feb 2020 11:40:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.114.17.106])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  7 Feb 2020 11:40:02 +0000 (GMT)
From:   Christian Borntraeger <borntraeger@de.ibm.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.vnet.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Thomas Huth <thuth@redhat.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Michael Mueller <mimu@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 21/35] KVM: s390/mm: handle guest unpin events
Date:   Fri,  7 Feb 2020 06:39:44 -0500
Message-Id: <20200207113958.7320-22-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200207113958.7320-1-borntraeger@de.ibm.com>
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-07_01:2020-02-07,2020-02-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002070089
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

The current code tries to first pin shared pages, if that fails (e.g.
because the page is not shared) it will export them. For shared pages
this means that we get a new intercept telling us that the guest is
unsharing that page. We will make the page secure at that point in time
and revoke the host access. This is synchronized with other host events,
e.g. the code will wait until host I/O has finished.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/intercept.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 2a966dc52611..e155389a4a66 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -16,6 +16,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/irq.h>
 #include <asm/sysinfo.h>
+#include <asm/uv.h>
 
 #include "kvm-s390.h"
 #include "gaccess.h"
@@ -484,12 +485,35 @@ static int handle_pv_sclp(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static int handle_pv_uvc(struct kvm_vcpu *vcpu)
+{
+	struct uv_cb_share *guest_uvcb = (void *)vcpu->arch.sie_block->sidad;
+	struct uv_cb_cts uvcb = {
+		.header.cmd	= UVC_CMD_UNPIN_PAGE_SHARED,
+		.header.len	= sizeof(uvcb),
+		.guest_handle	= kvm_s390_pv_handle(vcpu->kvm),
+		.gaddr		= guest_uvcb->paddr,
+	};
+	int rc;
+
+	if (guest_uvcb->header.cmd != UVC_CMD_REMOVE_SHARED_ACCESS) {
+		WARN_ONCE(1, "Unexpected UVC 0x%x!\n", guest_uvcb->header.cmd);
+		return 0;
+	}
+	rc = uv_make_secure(vcpu->arch.gmap, uvcb.gaddr, &uvcb);
+	if (rc == -EINVAL && uvcb.header.rc == 0x104)
+		return 0;
+	return rc;
+}
+
 static int handle_pv_notification(struct kvm_vcpu *vcpu)
 {
 	if (vcpu->arch.sie_block->ipa == 0xb210)
 		return handle_pv_spx(vcpu);
 	if (vcpu->arch.sie_block->ipa == 0xb220)
 		return handle_pv_sclp(vcpu);
+	if (vcpu->arch.sie_block->ipa == 0xb9a4)
+		return handle_pv_uvc(vcpu);
 
 	return handle_instruction(vcpu);
 }
-- 
2.24.0

