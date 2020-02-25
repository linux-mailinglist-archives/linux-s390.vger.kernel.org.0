Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C272616C201
	for <lists+linux-s390@lfdr.de>; Tue, 25 Feb 2020 14:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgBYNVN (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 25 Feb 2020 08:21:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21472 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729155AbgBYNVN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Feb 2020 08:21:13 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PDKt2D058339;
        Tue, 25 Feb 2020 08:21:12 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yb0g4k2wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 08:21:11 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01PDLBKW059372;
        Tue, 25 Feb 2020 08:21:11 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yb0g4k2vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 08:21:11 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01PDKwp7022492;
        Tue, 25 Feb 2020 13:21:10 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01dal.us.ibm.com with ESMTP id 2yaux6u4wt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 13:21:10 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01PDL8F038666630
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Feb 2020 13:21:08 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08255B2067;
        Tue, 25 Feb 2020 13:21:08 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3006B2065;
        Tue, 25 Feb 2020 13:21:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.114.17.106])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 25 Feb 2020 13:21:07 +0000 (GMT)
From:   Christian Borntraeger <borntraeger@de.ibm.com>
To:     cohuck@redhat.com
Cc:     Ulrich.Weigand@de.ibm.com, borntraeger@de.ibm.com,
        david@redhat.com, frankja@linux.ibm.com,
        frankja@linux.vnet.ibm.com, gor@linux.ibm.com,
        imbrenda@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, mimu@linux.ibm.com, thuth@redhat.com
Subject: [PATCH v4 28/36] KVM: s390: protvirt: Report CPU state to Ultravisor
Date:   Tue, 25 Feb 2020 08:21:06 -0500
Message-Id: <20200225132106.637817-1-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200225140151.5e639df1.cohuck@redhat.com>
References: <20200225140151.5e639df1.cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_04:2020-02-21,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 suspectscore=1 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250105
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Janosch Frank <frankja@linux.ibm.com>

VCPU states have to be reported to the ultravisor for SIGP
interpretation, kdump, kexec and reboot.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/uv.h | 15 +++++++++++++
 arch/s390/kvm/diag.c       |  6 +++++-
 arch/s390/kvm/intercept.c  |  4 ++++
 arch/s390/kvm/kvm-s390.c   | 44 +++++++++++++++++++++++++++++---------
 arch/s390/kvm/kvm-s390.h   |  5 +++--
 arch/s390/kvm/pv.c         | 18 ++++++++++++++++
 6 files changed, 79 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index a7595c647759..99e1a14ef909 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -37,6 +37,7 @@
 #define UVC_CMD_UNPACK_IMG		0x0301
 #define UVC_CMD_VERIFY_IMG		0x0302
 #define UVC_CMD_PREPARE_RESET		0x0320
+#define UVC_CMD_CPU_SET_STATE		0x0330
 #define UVC_CMD_SET_UNSHARE_ALL		0x0340
 #define UVC_CMD_PIN_PAGE_SHARED		0x0341
 #define UVC_CMD_UNPIN_PAGE_SHARED	0x0342
@@ -58,6 +59,7 @@ enum uv_cmds_inst {
 	BIT_UVC_CMD_SET_SEC_PARMS = 11,
 	BIT_UVC_CMD_UNPACK_IMG = 13,
 	BIT_UVC_CMD_VERIFY_IMG = 14,
+	BIT_UVC_CMD_CPU_SET_STATE = 17,
 	BIT_UVC_CMD_PREPARE_RESET = 18,
 	BIT_UVC_CMD_UNSHARE_ALL = 20,
 	BIT_UVC_CMD_PIN_PAGE_SHARED = 21,
@@ -164,6 +166,19 @@ struct uv_cb_unp {
 	u64 reserved38[3];
 } __packed __aligned(8);
 
+#define PV_CPU_STATE_OPR	1
+#define PV_CPU_STATE_STP	2
+#define PV_CPU_STATE_CHKSTP	3
+
+struct uv_cb_cpu_set_state {
+	struct uv_cb_header header;
+	u64 reserved08[2];
+	u64 cpu_handle;
+	u8  reserved20[7];
+	u8  state;
+	u64 reserved28[5];
+};
+
 /*
  * A common UV call struct for calls that take no payload
  * Examples:
diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 3fb54ec2cf3e..563429dece03 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -2,7 +2,7 @@
 /*
  * handling diagnose instructions
  *
- * Copyright IBM Corp. 2008, 2011
+ * Copyright IBM Corp. 2008, 2020
  *
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  *               Christian Borntraeger <borntraeger@de.ibm.com>
@@ -201,6 +201,10 @@ static int __diag_ipl_functions(struct kvm_vcpu *vcpu)
 		return -EOPNOTSUPP;
 	}
 
+	/*
+	 * no need to check the return value of vcpu_stop as it can only have
+	 * an error for protvirt, but protvirt means user cpu state
+	 */
 	if (!kvm_s390_user_cpu_state_ctrl(vcpu->kvm))
 		kvm_s390_vcpu_stop(vcpu);
 	vcpu->run->s390_reset_flags |= KVM_S390_RESET_SUBSYSTEM;
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index a93dfe9ae12a..c183c918cf8e 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -80,6 +80,10 @@ static int handle_stop(struct kvm_vcpu *vcpu)
 			return rc;
 	}
 
+	/*
+	 * no need to check the return value of vcpu_stop as it can only have
+	 * an error for protvirt, but protvirt means user cpu state
+	 */
 	if (!kvm_s390_user_cpu_state_ctrl(vcpu->kvm))
 		kvm_s390_vcpu_stop(vcpu);
 	return -EOPNOTSUPP;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index f318603be34c..33698a4cd3f9 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2458,6 +2458,8 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	case KVM_S390_PV_COMMAND: {
 		struct kvm_pv_cmd args;
 
+		/* protvirt means user sigp */
+		kvm->arch.user_cpu_state_ctrl = 1;
 		r = 0;
 		if (!is_prot_virt_host()) {
 			r = -EINVAL;
@@ -3720,10 +3722,10 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 
 	switch (mp_state->mp_state) {
 	case KVM_MP_STATE_STOPPED:
-		kvm_s390_vcpu_stop(vcpu);
+		rc = kvm_s390_vcpu_stop(vcpu);
 		break;
 	case KVM_MP_STATE_OPERATING:
-		kvm_s390_vcpu_start(vcpu);
+		rc = kvm_s390_vcpu_start(vcpu);
 		break;
 	case KVM_MP_STATE_LOAD:
 	case KVM_MP_STATE_CHECK_STOP:
@@ -4308,6 +4310,10 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 
 	kvm_sigset_activate(vcpu);
 
+	/*
+	 * no need to check the return value of vcpu_start as it can only have
+	 * an error for protvirt, but protvirt means user cpu state
+	 */
 	if (!kvm_s390_user_cpu_state_ctrl(vcpu->kvm)) {
 		kvm_s390_vcpu_start(vcpu);
 	} else if (is_vcpu_stopped(vcpu)) {
@@ -4445,18 +4451,27 @@ static void __enable_ibs_on_vcpu(struct kvm_vcpu *vcpu)
 	kvm_s390_sync_request(KVM_REQ_ENABLE_IBS, vcpu);
 }
 
-void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
+int kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
 {
-	int i, online_vcpus, started_vcpus = 0;
+	int i, online_vcpus, r = 0, started_vcpus = 0;
 
 	if (!is_vcpu_stopped(vcpu))
-		return;
+		return 0;
 
 	trace_kvm_s390_vcpu_start_stop(vcpu->vcpu_id, 1);
 	/* Only one cpu at a time may enter/leave the STOPPED state. */
 	spin_lock(&vcpu->kvm->arch.start_stop_lock);
 	online_vcpus = atomic_read(&vcpu->kvm->online_vcpus);
 
+	/* Let's tell the UV that we want to change into the operating state */
+	if (kvm_s390_pv_cpu_is_protected(vcpu)) {
+		r = kvm_s390_pv_set_cpu_state(vcpu, PV_CPU_STATE_OPR);
+		if (r) {
+			spin_unlock(&vcpu->kvm->arch.start_stop_lock);
+			return r;
+		}
+	}
+
 	for (i = 0; i < online_vcpus; i++) {
 		if (!is_vcpu_stopped(vcpu->kvm->vcpus[i]))
 			started_vcpus++;
@@ -4481,22 +4496,31 @@ void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
 	 */
 	kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
 	spin_unlock(&vcpu->kvm->arch.start_stop_lock);
-	return;
+	return 0;
 }
 
-void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
+int kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
 {
-	int i, online_vcpus, started_vcpus = 0;
+	int i, online_vcpus, r = 0, started_vcpus = 0;
 	struct kvm_vcpu *started_vcpu = NULL;
 
 	if (is_vcpu_stopped(vcpu))
-		return;
+		return 0;
 
 	trace_kvm_s390_vcpu_start_stop(vcpu->vcpu_id, 0);
 	/* Only one cpu at a time may enter/leave the STOPPED state. */
 	spin_lock(&vcpu->kvm->arch.start_stop_lock);
 	online_vcpus = atomic_read(&vcpu->kvm->online_vcpus);
 
+	/* Let's tell the UV that we want to change into the stopped state */
+	if (kvm_s390_pv_cpu_is_protected(vcpu)) {
+		r = kvm_s390_pv_set_cpu_state(vcpu, PV_CPU_STATE_STP);
+		if (r) {
+			spin_unlock(&vcpu->kvm->arch.start_stop_lock);
+			return r;
+		}
+	}
+
 	/* SIGP STOP and SIGP STOP AND STORE STATUS has been fully processed */
 	kvm_s390_clear_stop_irq(vcpu);
 
@@ -4519,7 +4543,7 @@ void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
 	}
 
 	spin_unlock(&vcpu->kvm->arch.start_stop_lock);
-	return;
+	return 0;
 }
 
 static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 13e6986596ed..79dcd647b378 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -217,6 +217,7 @@ int kvm_s390_pv_set_sec_parms(struct kvm *kvm, void *hdr, u64 length, u16 *rc,
 			      u16 *rrc);
 int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned long size,
 		       unsigned long tweak, u16 *rc, u16 *rrc);
+int kvm_s390_pv_set_cpu_state(struct kvm_vcpu *vcpu, u8 state);
 
 static inline u64 kvm_s390_pv_get_handle(struct kvm *kvm)
 {
@@ -330,8 +331,8 @@ void kvm_s390_set_tod_clock(struct kvm *kvm,
 long kvm_arch_fault_in_page(struct kvm_vcpu *vcpu, gpa_t gpa, int writable);
 int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long addr);
 int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, unsigned long addr);
-void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu);
-void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu);
+int kvm_s390_vcpu_start(struct kvm_vcpu *vcpu);
+int kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu);
 void kvm_s390_vcpu_block(struct kvm_vcpu *vcpu);
 void kvm_s390_vcpu_unblock(struct kvm_vcpu *vcpu);
 bool kvm_s390_vcpu_sie_inhibited(struct kvm_vcpu *vcpu);
diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index b4d00f039dea..89fad2a4016b 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -283,3 +283,21 @@ int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned long size,
 		KVM_UV_EVENT(kvm, 3, "%s", "PROTVIRT VM UNPACK: successful");
 	return ret;
 }
+
+int kvm_s390_pv_set_cpu_state(struct kvm_vcpu *vcpu, u8 state)
+{
+	struct uv_cb_cpu_set_state uvcb = {
+		.header.cmd	= UVC_CMD_CPU_SET_STATE,
+		.header.len	= sizeof(uvcb),
+		.cpu_handle	= kvm_s390_pv_cpu_get_handle(vcpu),
+		.state		= state,
+	};
+	int cc;
+
+	cc = uv_call(0, (u64)&uvcb);
+	KVM_UV_EVENT(vcpu->kvm, 3, "PROTVIRT SET CPU %d STATE %d rc %x rrc %x",
+		     vcpu->vcpu_id, state, uvcb.header.rc, uvcb.header.rrc);
+	if (cc)
+		return -EINVAL;
+	return 0;
+}
-- 
2.25.0

