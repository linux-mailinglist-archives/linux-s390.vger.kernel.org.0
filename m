Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6C7530E0B
	for <lists+linux-s390@lfdr.de>; Mon, 23 May 2022 12:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbiEWJ4h (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 23 May 2022 05:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbiEWJ4f (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 23 May 2022 05:56:35 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD60D2BFB;
        Mon, 23 May 2022 02:56:33 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24N9hR0k007256;
        Mon, 23 May 2022 09:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=NNXqlIcoXYiBNC1TrZO4wIzt+AMgEjyc7qn8wA8qW+4=;
 b=bQPM1LKaMwJBxVdcmML1/llPyR0gj22nv1oXRO5zWOhlM1xAyMxdoEFbd12rXznVwtAG
 tL0vETqTHE/jfu0gUEmWj14Q5Aapp2z5qcOc1ngvKaFvGvINRAmQ9S1WnlPDgXXligQH
 jzeFXsYROrIoWN3+jI7A7IP0abVfAnurZ9THxytHgUoj3q26q11z3MULYKBgofDNUHnB
 RBf7/K6A4POh8j2nSKh03TmBuUU4krlZGnUkc5z21lDbCe6P8JjTW3vImuADLAbzx1Zo
 YZ1UJVe6DTV3BD37Jmf5vUOP0k4o9+AcIiTXt8XUYafZ4mJ7v0ZAloNxZ8B7+auY3s3v yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g87vvratr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 09:56:32 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24N9hg7W007578;
        Mon, 23 May 2022 09:56:32 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g87vvrasr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 09:56:32 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24N9K5tI002515;
        Mon, 23 May 2022 09:56:30 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3g6qq9a5ab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 09:56:30 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24N9uQXb55312726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 09:56:26 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B802B42047;
        Mon, 23 May 2022 09:56:26 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A618442042;
        Mon, 23 May 2022 09:56:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 23 May 2022 09:56:26 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
        id 6A364E7965; Mon, 23 May 2022 11:56:26 +0200 (CEST)
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>
Subject: [GIT PULL 3/4] KVM: s390: Don't indicate suppression on dirtying, failing memop
Date:   Mon, 23 May 2022 11:56:24 +0200
Message-Id: <20220523095625.13913-4-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220523095625.13913-1-borntraeger@linux.ibm.com>
References: <20220523095625.13913-1-borntraeger@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0BPu52Eq6VWC1ZDVJOB_K6UMpbAuzXZi
X-Proofpoint-ORIG-GUID: f_uGHjuBLpUrRTWeKaSrQmJpXcj13cyu
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-23_03,2022-05-20_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205230051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Janis Schoetterl-Glausch <scgl@linux.ibm.com>

If user space uses a memop to emulate an instruction and that
memop fails, the execution of the instruction ends.
Instruction execution can end in different ways, one of which is
suppression, which requires that the instruction execute like a no-op.
A writing memop that spans multiple pages and fails due to key
protection may have modified guest memory, as a result, the likely
correct ending is termination. Therefore, do not indicate a
suppressing instruction ending in this case.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Link: https://lore.kernel.org/r/20220512131019.2594948-2-scgl@linux.ibm.com
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 Documentation/virt/kvm/api.rst |  6 ++++++
 arch/s390/kvm/gaccess.c        | 22 ++++++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index d13fa6600467..09353e27bdbc 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -3754,12 +3754,18 @@ in case of KVM_S390_MEMOP_F_CHECK_ONLY), the ioctl returns a positive
 error number indicating the type of exception. This exception is also
 raised directly at the corresponding VCPU if the flag
 KVM_S390_MEMOP_F_INJECT_EXCEPTION is set.
+On protection exceptions, unless specified otherwise, the injected
+translation-exception identifier (TEID) indicates suppression.
 
 If the KVM_S390_MEMOP_F_SKEY_PROTECTION flag is set, storage key
 protection is also in effect and may cause exceptions if accesses are
 prohibited given the access key designated by "key"; the valid range is 0..15.
 KVM_S390_MEMOP_F_SKEY_PROTECTION is available if KVM_CAP_S390_MEM_OP_EXTENSION
 is > 0.
+Since the accessed memory may span multiple pages and those pages might have
+different storage keys, it is possible that a protection exception occurs
+after memory has been modified. In this case, if the exception is injected,
+the TEID does not indicate suppression.
 
 Absolute read/write:
 ^^^^^^^^^^^^^^^^^^^^
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index d53a183c2005..227ed0009354 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -491,8 +491,8 @@ enum prot_type {
 	PROT_TYPE_IEP  = 4,
 };
 
-static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva,
-		     u8 ar, enum gacc_mode mode, enum prot_type prot)
+static int trans_exc_ending(struct kvm_vcpu *vcpu, int code, unsigned long gva, u8 ar,
+			    enum gacc_mode mode, enum prot_type prot, bool terminate)
 {
 	struct kvm_s390_pgm_info *pgm = &vcpu->arch.pgm;
 	struct trans_exc_code_bits *tec;
@@ -520,6 +520,11 @@ static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva,
 			tec->b61 = 1;
 			break;
 		}
+		if (terminate) {
+			tec->b56 = 0;
+			tec->b60 = 0;
+			tec->b61 = 0;
+		}
 		fallthrough;
 	case PGM_ASCE_TYPE:
 	case PGM_PAGE_TRANSLATION:
@@ -552,6 +557,12 @@ static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva,
 	return code;
 }
 
+static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva, u8 ar,
+		     enum gacc_mode mode, enum prot_type prot)
+{
+	return trans_exc_ending(vcpu, code, gva, ar, mode, prot, false);
+}
+
 static int get_vcpu_asce(struct kvm_vcpu *vcpu, union asce *asce,
 			 unsigned long ga, u8 ar, enum gacc_mode mode)
 {
@@ -1109,8 +1120,11 @@ int access_guest_with_key(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
 		data += fragment_len;
 		ga = kvm_s390_logical_to_effective(vcpu, ga + fragment_len);
 	}
-	if (rc > 0)
-		rc = trans_exc(vcpu, rc, ga, ar, mode, prot);
+	if (rc > 0) {
+		bool terminate = (mode == GACC_STORE) && (idx > 0);
+
+		rc = trans_exc_ending(vcpu, rc, ga, ar, mode, prot, terminate);
+	}
 out_unlock:
 	if (need_ipte_lock)
 		ipte_unlock(vcpu);
-- 
2.35.1

