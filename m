Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED03051D430
	for <lists+linux-s390@lfdr.de>; Fri,  6 May 2022 11:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390421AbiEFJYp (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 6 May 2022 05:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344441AbiEFJYn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 6 May 2022 05:24:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CF06353E;
        Fri,  6 May 2022 02:20:36 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2469BWQR017006;
        Fri, 6 May 2022 09:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=3oQTRMoYp+AixGBGNuC1ls5eRuRl1O9hEo1EWzhPnoA=;
 b=RvOgT8u3eoMUpNnPxwZ0Jwtl7ORHoODoD63zqLTb21H0112xGDprn0ESUYClEhutuGtF
 Hlt59Fvqsn8w3Z+48X3klna4UZk0Xx66Skgvk4hBKnZks82IsAPx0UvNB40eCJM7/gEY
 Mgq25Nnq65HpZk0C9oimExTiTdg3F8IQMqKxbMS8AnoNVizoHzf6P29QCFg3pdRlDbGl
 2dpVdfOqEXpjQW1k0mZg3buk5OH3K5vx0anASB1THWphTxfDm6iPK9CfByEu4z+PvTN6
 0wuCIZ5VkPyVmrNNZw8HtbWPsricZkZOmrRrqh2++iGrt7poX5Li/dY5SdBE2PlN6KZq 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fw0twg5sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 09:20:36 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2469DS4m031498;
        Fri, 6 May 2022 09:20:36 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fw0twg5s4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 09:20:35 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2469Ca6f032483;
        Fri, 6 May 2022 09:20:33 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3fscdk6491-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 09:20:33 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 246975np37224916
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 May 2022 09:07:05 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DC7D11C050;
        Fri,  6 May 2022 09:20:30 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C81911C04A;
        Fri,  6 May 2022 09:20:29 +0000 (GMT)
Received: from li-c6ac47cc-293c-11b2-a85c-d421c8e4747b.ibm.com.com (unknown [9.171.62.79])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 May 2022 09:20:29 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, cohuck@redhat.com,
        david@redhat.com, thuth@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, pmorel@linux.ibm.com,
        wintera@linux.ibm.com, seiden@linux.ibm.com, nrb@linux.ibm.com
Subject: [PATCH v9 1/3] s390x: KVM: ipte lock for SCA access should be contained in KVM
Date:   Fri,  6 May 2022 11:24:01 +0200
Message-Id: <20220506092403.47406-2-pmorel@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220506092403.47406-1-pmorel@linux.ibm.com>
References: <20220506092403.47406-1-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: td-57-6C1AUw_ZcRZRqUx2k0PkOf3Qqw
X-Proofpoint-GUID: 1qMrtwPSY2SkKyXwypD_dK-M6DAA2snb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-06_03,2022-05-05_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 spamscore=0
 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2205060049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The former check to chose between SIIF or not SIIF can be done
using the sclp.has_siif instead of accessing per vCPU structures

When accessing the SCA, ipte lock and ipte_unlock do not need
to access any vcpu structures but only the KVM structure.

Let's simplify the ipte handling.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 arch/s390/kvm/gaccess.c | 96 ++++++++++++++++++++---------------------
 arch/s390/kvm/gaccess.h |  6 +--
 arch/s390/kvm/priv.c    |  6 +--
 3 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index d53a183c2005..0e1f6dd31882 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -262,77 +262,77 @@ struct aste {
 	/* .. more fields there */
 };
 
-int ipte_lock_held(struct kvm_vcpu *vcpu)
+int ipte_lock_held(struct kvm *kvm)
 {
-	if (vcpu->arch.sie_block->eca & ECA_SII) {
+	if (sclp.has_siif) {
 		int rc;
 
-		read_lock(&vcpu->kvm->arch.sca_lock);
-		rc = kvm_s390_get_ipte_control(vcpu->kvm)->kh != 0;
-		read_unlock(&vcpu->kvm->arch.sca_lock);
+		read_lock(&kvm->arch.sca_lock);
+		rc = kvm_s390_get_ipte_control(kvm)->kh != 0;
+		read_unlock(&kvm->arch.sca_lock);
 		return rc;
 	}
-	return vcpu->kvm->arch.ipte_lock_count != 0;
+	return kvm->arch.ipte_lock_count != 0;
 }
 
-static void ipte_lock_simple(struct kvm_vcpu *vcpu)
+static void ipte_lock_simple(struct kvm *kvm)
 {
 	union ipte_control old, new, *ic;
 
-	mutex_lock(&vcpu->kvm->arch.ipte_mutex);
-	vcpu->kvm->arch.ipte_lock_count++;
-	if (vcpu->kvm->arch.ipte_lock_count > 1)
+	mutex_lock(&kvm->arch.ipte_mutex);
+	kvm->arch.ipte_lock_count++;
+	if (kvm->arch.ipte_lock_count > 1)
 		goto out;
 retry:
-	read_lock(&vcpu->kvm->arch.sca_lock);
-	ic = kvm_s390_get_ipte_control(vcpu->kvm);
+	read_lock(&kvm->arch.sca_lock);
+	ic = kvm_s390_get_ipte_control(kvm);
 	do {
 		old = READ_ONCE(*ic);
 		if (old.k) {
-			read_unlock(&vcpu->kvm->arch.sca_lock);
+			read_unlock(&kvm->arch.sca_lock);
 			cond_resched();
 			goto retry;
 		}
 		new = old;
 		new.k = 1;
 	} while (cmpxchg(&ic->val, old.val, new.val) != old.val);
-	read_unlock(&vcpu->kvm->arch.sca_lock);
+	read_unlock(&kvm->arch.sca_lock);
 out:
-	mutex_unlock(&vcpu->kvm->arch.ipte_mutex);
+	mutex_unlock(&kvm->arch.ipte_mutex);
 }
 
-static void ipte_unlock_simple(struct kvm_vcpu *vcpu)
+static void ipte_unlock_simple(struct kvm *kvm)
 {
 	union ipte_control old, new, *ic;
 
-	mutex_lock(&vcpu->kvm->arch.ipte_mutex);
-	vcpu->kvm->arch.ipte_lock_count--;
-	if (vcpu->kvm->arch.ipte_lock_count)
+	mutex_lock(&kvm->arch.ipte_mutex);
+	kvm->arch.ipte_lock_count--;
+	if (kvm->arch.ipte_lock_count)
 		goto out;
-	read_lock(&vcpu->kvm->arch.sca_lock);
-	ic = kvm_s390_get_ipte_control(vcpu->kvm);
+	read_lock(&kvm->arch.sca_lock);
+	ic = kvm_s390_get_ipte_control(kvm);
 	do {
 		old = READ_ONCE(*ic);
 		new = old;
 		new.k = 0;
 	} while (cmpxchg(&ic->val, old.val, new.val) != old.val);
-	read_unlock(&vcpu->kvm->arch.sca_lock);
-	wake_up(&vcpu->kvm->arch.ipte_wq);
+	read_unlock(&kvm->arch.sca_lock);
+	wake_up(&kvm->arch.ipte_wq);
 out:
-	mutex_unlock(&vcpu->kvm->arch.ipte_mutex);
+	mutex_unlock(&kvm->arch.ipte_mutex);
 }
 
-static void ipte_lock_siif(struct kvm_vcpu *vcpu)
+static void ipte_lock_siif(struct kvm *kvm)
 {
 	union ipte_control old, new, *ic;
 
 retry:
-	read_lock(&vcpu->kvm->arch.sca_lock);
-	ic = kvm_s390_get_ipte_control(vcpu->kvm);
+	read_lock(&kvm->arch.sca_lock);
+	ic = kvm_s390_get_ipte_control(kvm);
 	do {
 		old = READ_ONCE(*ic);
 		if (old.kg) {
-			read_unlock(&vcpu->kvm->arch.sca_lock);
+			read_unlock(&kvm->arch.sca_lock);
 			cond_resched();
 			goto retry;
 		}
@@ -340,15 +340,15 @@ static void ipte_lock_siif(struct kvm_vcpu *vcpu)
 		new.k = 1;
 		new.kh++;
 	} while (cmpxchg(&ic->val, old.val, new.val) != old.val);
-	read_unlock(&vcpu->kvm->arch.sca_lock);
+	read_unlock(&kvm->arch.sca_lock);
 }
 
-static void ipte_unlock_siif(struct kvm_vcpu *vcpu)
+static void ipte_unlock_siif(struct kvm *kvm)
 {
 	union ipte_control old, new, *ic;
 
-	read_lock(&vcpu->kvm->arch.sca_lock);
-	ic = kvm_s390_get_ipte_control(vcpu->kvm);
+	read_lock(&kvm->arch.sca_lock);
+	ic = kvm_s390_get_ipte_control(kvm);
 	do {
 		old = READ_ONCE(*ic);
 		new = old;
@@ -356,25 +356,25 @@ static void ipte_unlock_siif(struct kvm_vcpu *vcpu)
 		if (!new.kh)
 			new.k = 0;
 	} while (cmpxchg(&ic->val, old.val, new.val) != old.val);
-	read_unlock(&vcpu->kvm->arch.sca_lock);
+	read_unlock(&kvm->arch.sca_lock);
 	if (!new.kh)
-		wake_up(&vcpu->kvm->arch.ipte_wq);
+		wake_up(&kvm->arch.ipte_wq);
 }
 
-void ipte_lock(struct kvm_vcpu *vcpu)
+void ipte_lock(struct kvm *kvm)
 {
-	if (vcpu->arch.sie_block->eca & ECA_SII)
-		ipte_lock_siif(vcpu);
+	if (sclp.has_siif)
+		ipte_lock_siif(kvm);
 	else
-		ipte_lock_simple(vcpu);
+		ipte_lock_simple(kvm);
 }
 
-void ipte_unlock(struct kvm_vcpu *vcpu)
+void ipte_unlock(struct kvm *kvm)
 {
-	if (vcpu->arch.sie_block->eca & ECA_SII)
-		ipte_unlock_siif(vcpu);
+	if (sclp.has_siif)
+		ipte_unlock_siif(kvm);
 	else
-		ipte_unlock_simple(vcpu);
+		ipte_unlock_simple(kvm);
 }
 
 static int ar_translation(struct kvm_vcpu *vcpu, union asce *asce, u8 ar,
@@ -1075,7 +1075,7 @@ int access_guest_with_key(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
 	try_storage_prot_override = storage_prot_override_applicable(vcpu);
 	need_ipte_lock = psw_bits(*psw).dat && !asce.r;
 	if (need_ipte_lock)
-		ipte_lock(vcpu);
+		ipte_lock(vcpu->kvm);
 	/*
 	 * Since we do the access further down ultimately via a move instruction
 	 * that does key checking and returns an error in case of a protection
@@ -1113,7 +1113,7 @@ int access_guest_with_key(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
 		rc = trans_exc(vcpu, rc, ga, ar, mode, prot);
 out_unlock:
 	if (need_ipte_lock)
-		ipte_unlock(vcpu);
+		ipte_unlock(vcpu->kvm);
 	if (nr_pages > ARRAY_SIZE(gpa_array))
 		vfree(gpas);
 	return rc;
@@ -1185,10 +1185,10 @@ int check_gva_range(struct kvm_vcpu *vcpu, unsigned long gva, u8 ar,
 	rc = get_vcpu_asce(vcpu, &asce, gva, ar, mode);
 	if (rc)
 		return rc;
-	ipte_lock(vcpu);
+	ipte_lock(vcpu->kvm);
 	rc = guest_range_to_gpas(vcpu, gva, ar, NULL, length, asce, mode,
 				 access_key);
-	ipte_unlock(vcpu);
+	ipte_unlock(vcpu->kvm);
 
 	return rc;
 }
@@ -1451,7 +1451,7 @@ int kvm_s390_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg,
 	 * tables/pointers we read stay valid - unshadowing is however
 	 * always possible - only guest_table_lock protects us.
 	 */
-	ipte_lock(vcpu);
+	ipte_lock(vcpu->kvm);
 
 	rc = gmap_shadow_pgt_lookup(sg, saddr, &pgt, &dat_protection, &fake);
 	if (rc)
@@ -1485,7 +1485,7 @@ int kvm_s390_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg,
 	pte.p |= dat_protection;
 	if (!rc)
 		rc = gmap_shadow_page(sg, saddr, __pte(pte.val));
-	ipte_unlock(vcpu);
+	ipte_unlock(vcpu->kvm);
 	mmap_read_unlock(sg->mm);
 	return rc;
 }
diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index 1124ff282012..9408d6cc8e2c 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -440,9 +440,9 @@ int read_guest_real(struct kvm_vcpu *vcpu, unsigned long gra, void *data,
 	return access_guest_real(vcpu, gra, data, len, 0);
 }
 
-void ipte_lock(struct kvm_vcpu *vcpu);
-void ipte_unlock(struct kvm_vcpu *vcpu);
-int ipte_lock_held(struct kvm_vcpu *vcpu);
+void ipte_lock(struct kvm *kvm);
+void ipte_unlock(struct kvm *kvm);
+int ipte_lock_held(struct kvm *kvm);
 int kvm_s390_check_low_addr_prot_real(struct kvm_vcpu *vcpu, unsigned long gra);
 
 /* MVPG PEI indication bits */
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 5beb7a4a11b3..0e8603acc105 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -443,7 +443,7 @@ static int handle_ipte_interlock(struct kvm_vcpu *vcpu)
 	vcpu->stat.instruction_ipte_interlock++;
 	if (psw_bits(vcpu->arch.sie_block->gpsw).pstate)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
-	wait_event(vcpu->kvm->arch.ipte_wq, !ipte_lock_held(vcpu));
+	wait_event(vcpu->kvm->arch.ipte_wq, !ipte_lock_held(vcpu->kvm));
 	kvm_s390_retry_instr(vcpu);
 	VCPU_EVENT(vcpu, 4, "%s", "retrying ipte interlock operation");
 	return 0;
@@ -1472,7 +1472,7 @@ static int handle_tprot(struct kvm_vcpu *vcpu)
 	access_key = (operand2 & 0xf0) >> 4;
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_DAT)
-		ipte_lock(vcpu);
+		ipte_lock(vcpu->kvm);
 
 	ret = guest_translate_address_with_key(vcpu, address, ar, &gpa,
 					       GACC_STORE, access_key);
@@ -1509,7 +1509,7 @@ static int handle_tprot(struct kvm_vcpu *vcpu)
 	}
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_DAT)
-		ipte_unlock(vcpu);
+		ipte_unlock(vcpu->kvm);
 	return ret;
 }
 
-- 
2.27.0

