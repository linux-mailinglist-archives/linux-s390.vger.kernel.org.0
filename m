Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3671136A2B
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jan 2020 10:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgAJJrL (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 10 Jan 2020 04:47:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50122 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727219AbgAJJrL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 10 Jan 2020 04:47:11 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00A9g5Ki146380
        for <linux-s390@vger.kernel.org>; Fri, 10 Jan 2020 04:47:10 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xe0sm866h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Jan 2020 04:47:09 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 10 Jan 2020 09:47:08 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 10 Jan 2020 09:47:05 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00A9kGE042926480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jan 2020 09:46:16 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48A1DA405C;
        Fri, 10 Jan 2020 09:47:04 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91641A405B;
        Fri, 10 Jan 2020 09:47:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.153.163])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 10 Jan 2020 09:47:02 +0000 (GMT)
From:   Janosch Frank <frankja@linux.ibm.com>
To:     kvm@vger.kernel.org
Cc:     thuth@redhat.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com
Subject: [PATCH v5] KVM: s390: Add new reset vcpu API
Date:   Fri, 10 Jan 2020 04:46:59 -0500
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20011009-0012-0000-0000-0000037C308F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011009-0013-0000-0000-000021B85457
Message-Id: <20200110094659.4118-1-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-10_01:2020-01-10,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 adultscore=0 mlxlogscore=999 impostorscore=0
 spamscore=0 suspectscore=1 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001100083
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The architecture states that we need to reset local IRQs for all CPU
resets. Because the old reset interface did not support the normal CPU
reset we never did that on a normal reset.

Let's implement an interface for the missing normal and clear resets
and reset all local IRQs, registers and control structures as stated
in the architecture.

Userspace might already reset the registers via the vcpu run struct,
but as we need the interface for the interrupt clearing part anyway,
we implement the resets fully and don't rely on userspace to reset the
rest.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 Documentation/virt/kvm/api.txt |  45 +++++++++++++
 arch/s390/kvm/kvm-s390.c       | 111 +++++++++++++++++++++++----------
 include/uapi/linux/kvm.h       |   5 ++
 3 files changed, 127 insertions(+), 34 deletions(-)

diff --git a/Documentation/virt/kvm/api.txt b/Documentation/virt/kvm/api.txt
index ebb37b34dcfc..5203d95b1a21 100644
--- a/Documentation/virt/kvm/api.txt
+++ b/Documentation/virt/kvm/api.txt
@@ -4168,6 +4168,44 @@ This ioctl issues an ultravisor call to terminate the secure guest,
 unpins the VPA pages and releases all the device pages that are used to
 track the secure pages by hypervisor.
 
+4.122 KVM_S390_NORMAL_RESET
+
+Capability: KVM_CAP_S390_VCPU_RESETS
+Architectures: s390
+Type: vcpu ioctl
+Parameters: none
+Returns: 0
+
+This ioctl resets VCPU registers and control structures according to
+the cpu reset definition in the POP (Principles Of Operation).
+
+4.123 KVM_S390_INITIAL_RESET
+
+Capability: none
+Architectures: s390
+Type: vcpu ioctl
+Parameters: none
+Returns: 0
+
+This ioctl resets VCPU registers and control structures according to
+the initial cpu reset definition in the POP (Principles Of
+Operation). However, the cpu is not put into ESA mode. This reset is a
+superset of the normal reset.
+
+4.124 KVM_S390_CLEAR_RESET
+
+Capability: KVM_CAP_S390_VCPU_RESETS
+Architectures: s390
+Type: vcpu ioctl
+Parameters: none
+Returns: 0
+
+This ioctl resets VCPU registers and control structures according to
+the clear cpu reset definition in the POP (Principles Of Operation).
+However, the cpu is not put into ESA mode. This reset is a superset
+of the initial reset.
+
+
 5. The kvm_run structure
 ------------------------
 
@@ -5396,3 +5434,10 @@ handling by KVM (as some KVM hypercall may be mistakenly treated as TLB
 flush hypercalls by Hyper-V) so userspace should disable KVM identification
 in CPUID and only exposes Hyper-V identification. In this case, guest
 thinks it's running on Hyper-V and only use Hyper-V hypercalls.
+
+8.22 KVM_CAP_S390_VCPU_RESETS
+
+Architectures: s390
+
+This capability indicates that the KVM_S390_NORMAL_RESET and
+KVM_S390_CLEAR_RESET ioctls are available.
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d9e6bf3d54f0..7ed6dc5bd481 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -529,6 +529,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_S390_CMMA_MIGRATION:
 	case KVM_CAP_S390_AIS:
 	case KVM_CAP_S390_AIS_MIGRATION:
+	case KVM_CAP_S390_VCPU_RESETS:
 		r = 1;
 		break;
 	case KVM_CAP_S390_HPAGE_1M:
@@ -2844,35 +2845,6 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 
 }
 
-static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
-{
-	/* this equals initial cpu reset in pop, but we don't switch to ESA */
-	vcpu->arch.sie_block->gpsw.mask = 0UL;
-	vcpu->arch.sie_block->gpsw.addr = 0UL;
-	kvm_s390_set_prefix(vcpu, 0);
-	kvm_s390_set_cpu_timer(vcpu, 0);
-	vcpu->arch.sie_block->ckc       = 0UL;
-	vcpu->arch.sie_block->todpr     = 0;
-	memset(vcpu->arch.sie_block->gcr, 0, 16 * sizeof(__u64));
-	vcpu->arch.sie_block->gcr[0]  = CR0_UNUSED_56 |
-					CR0_INTERRUPT_KEY_SUBMASK |
-					CR0_MEASUREMENT_ALERT_SUBMASK;
-	vcpu->arch.sie_block->gcr[14] = CR14_UNUSED_32 |
-					CR14_UNUSED_33 |
-					CR14_EXTERNAL_DAMAGE_SUBMASK;
-	/* make sure the new fpc will be lazily loaded */
-	save_fpu_regs();
-	current->thread.fpu.fpc = 0;
-	vcpu->arch.sie_block->gbea = 1;
-	vcpu->arch.sie_block->pp = 0;
-	vcpu->arch.sie_block->fpf &= ~FPF_BPBC;
-	vcpu->arch.pfault_token = KVM_S390_PFAULT_TOKEN_INVALID;
-	kvm_clear_async_pf_completion_queue(vcpu);
-	if (!kvm_s390_user_cpu_state_ctrl(vcpu->kvm))
-		kvm_s390_vcpu_stop(vcpu);
-	kvm_s390_clear_local_irqs(vcpu);
-}
-
 void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 {
 	mutex_lock(&vcpu->kvm->lock);
@@ -3287,10 +3259,74 @@ static int kvm_arch_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu,
 	return r;
 }
 
-static int kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
+static void kvm_arch_vcpu_ioctl_normal_reset(struct kvm_vcpu *vcpu)
 {
-	kvm_s390_vcpu_initial_reset(vcpu);
-	return 0;
+	vcpu->arch.sie_block->gpsw.mask = ~PSW_MASK_RI;
+	vcpu->arch.pfault_token = KVM_S390_PFAULT_TOKEN_INVALID;
+	memset(vcpu->run->s.regs.riccb, 0, sizeof(vcpu->run->s.regs.riccb));
+
+	kvm_clear_async_pf_completion_queue(vcpu);
+	if (!kvm_s390_user_cpu_state_ctrl(vcpu->kvm))
+		kvm_s390_vcpu_stop(vcpu);
+	kvm_s390_clear_local_irqs(vcpu);
+}
+
+static void kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
+{
+	/* this equals initial cpu reset in pop, but we don't switch to ESA */
+	vcpu->arch.sie_block->gpsw.mask = 0UL;
+	vcpu->arch.sie_block->gpsw.addr = 0UL;
+	kvm_s390_set_prefix(vcpu, 0);
+	kvm_s390_set_cpu_timer(vcpu, 0);
+	vcpu->arch.sie_block->ckc       = 0UL;
+	vcpu->arch.sie_block->todpr     = 0;
+	memset(vcpu->arch.sie_block->gcr, 0, 16 * sizeof(__u64));
+	vcpu->arch.sie_block->gcr[0]  = CR0_UNUSED_56 |
+					CR0_INTERRUPT_KEY_SUBMASK |
+					CR0_MEASUREMENT_ALERT_SUBMASK;
+	vcpu->arch.sie_block->gcr[14] = CR14_UNUSED_32 |
+					CR14_UNUSED_33 |
+					CR14_EXTERNAL_DAMAGE_SUBMASK;
+	/* make sure the new fpc will be lazily loaded */
+	save_fpu_regs();
+	current->thread.fpu.fpc = 0;
+	vcpu->arch.sie_block->gbea = 1;
+	vcpu->arch.sie_block->pp = 0;
+	vcpu->arch.sie_block->fpf &= ~FPF_BPBC;
+	/* remaining work needs to be done in normal reset */
+}
+
+static void kvm_arch_vcpu_ioctl_clear_reset(struct kvm_vcpu *vcpu)
+{
+	struct kvm_sync_regs *regs = &vcpu->run->s.regs;
+
+	memset(&regs->gprs, 0, sizeof(regs->gprs));
+	/*
+	 * Will be picked up via save_fpu_regs() in the initial reset
+	 * fallthrough.
+	 */
+	memset(&regs->vrs, 0, sizeof(regs->vrs));
+	memset(&regs->acrs, 0, sizeof(regs->acrs));
+
+	regs->etoken = 0;
+	regs->etoken_extension = 0;
+
+	memset(&regs->gscb, 0, sizeof(regs->gscb));
+	if (MACHINE_HAS_GS) {
+		preempt_disable();
+		__ctl_set_bit(2, 4);
+		if (current->thread.gs_cb) {
+			vcpu->arch.host_gscb = current->thread.gs_cb;
+			save_gs_cb(vcpu->arch.host_gscb);
+		}
+		if (vcpu->arch.gs_enabled) {
+			current->thread.gs_cb = (struct gs_cb *)
+				&vcpu->run->s.regs.gscb;
+			restore_gs_cb(current->thread.gs_cb);
+		}
+		preempt_enable();
+	}
+	/* remaining work needs to be done in initial and normal reset */
 }
 
 int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
@@ -4344,7 +4380,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	struct kvm_vcpu *vcpu = filp->private_data;
 	void __user *argp = (void __user *)arg;
 	int idx;
-	long r;
+	long r = 0;
 
 	vcpu_load(vcpu);
 
@@ -4363,8 +4399,15 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		r = kvm_arch_vcpu_ioctl_set_initial_psw(vcpu, psw);
 		break;
 	}
+
+	case KVM_S390_CLEAR_RESET:
+		kvm_arch_vcpu_ioctl_clear_reset(vcpu);
+		/* fallthrough */
 	case KVM_S390_INITIAL_RESET:
-		r = kvm_arch_vcpu_ioctl_initial_reset(vcpu);
+		kvm_arch_vcpu_ioctl_initial_reset(vcpu);
+		/* fallthrough */
+	case KVM_S390_NORMAL_RESET:
+		kvm_arch_vcpu_ioctl_normal_reset(vcpu);
 		break;
 	case KVM_SET_ONE_REG:
 	case KVM_GET_ONE_REG: {
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index f0a16b4adbbd..4b95f9a31a2f 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1009,6 +1009,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PPC_GUEST_DEBUG_SSTEP 176
 #define KVM_CAP_ARM_NISV_TO_USER 177
 #define KVM_CAP_ARM_INJECT_EXT_DABT 178
+#define KVM_CAP_S390_VCPU_RESETS 179
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1473,6 +1474,10 @@ struct kvm_enc_region {
 /* Available with KVM_CAP_ARM_SVE */
 #define KVM_ARM_VCPU_FINALIZE	  _IOW(KVMIO,  0xc2, int)
 
+/* Available with  KVM_CAP_S390_VCPU_RESETS */
+#define KVM_S390_NORMAL_RESET	_IO(KVMIO,   0xc3)
+#define KVM_S390_CLEAR_RESET	_IO(KVMIO,   0xc4)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */
-- 
2.20.1

