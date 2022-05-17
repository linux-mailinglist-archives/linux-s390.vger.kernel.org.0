Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3645552A82C
	for <lists+linux-s390@lfdr.de>; Tue, 17 May 2022 18:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351019AbiEQQhD (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 17 May 2022 12:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351001AbiEQQg7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 17 May 2022 12:36:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B872E08F;
        Tue, 17 May 2022 09:36:56 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HGXOTC013038;
        Tue, 17 May 2022 16:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Uzgo6CbPHx1h9gYadhV4HcfgSkDJoJFTgYlJOW3dGCQ=;
 b=mXItah+ipUINcLw3rcxr94OqXK+kCwrusEYcJ2nPD3Gmm4buCYHtbn4hPYahNf8C/VOS
 PtX6tMI+e/RG/ot3Ffvf4yN/RBmsNF4YR2c9KKptXAH8YbcdQcMggOu2A+AvDLLHDkfo
 Z3E/zD+CzH8LFscoQ4RNSnTgqhd4/t0BDPaxRu9Ta3hrciACuxgyIGogEUNa5RiY71Np
 d8aE0AuBTwcwq0Z1lRGps3+24rp5cihf2pd2/6MhTAHUpW/zIdYBF1I0M2NZq7PtqBnL
 UI47SxKxDqXzrcJJDzCOkyPYWQoaC6R8qt71SGgJPfd9gU5ki8rIjBjgSMdihBwXp6g7 dA== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g4fb3044v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 16:36:55 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24HGWmH3011862;
        Tue, 17 May 2022 16:36:54 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 3g2428umwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 16:36:54 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24HGao3k37945802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 16:36:50 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB91111C04C;
        Tue, 17 May 2022 16:36:50 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EB8011C04A;
        Tue, 17 May 2022 16:36:50 +0000 (GMT)
Received: from linux6.. (unknown [9.114.12.104])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 17 May 2022 16:36:50 +0000 (GMT)
From:   Janosch Frank <frankja@linux.ibm.com>
To:     kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com
Subject: [PATCH v6 06/11] kvm: s390: Add configuration dump functionality
Date:   Tue, 17 May 2022 16:36:24 +0000
Message-Id: <20220517163629.3443-7-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220517163629.3443-1-frankja@linux.ibm.com>
References: <20220517163629.3443-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KNsyKtMuUY-rriLdGPzobMHFmWGFkdcW
X-Proofpoint-GUID: KNsyKtMuUY-rriLdGPzobMHFmWGFkdcW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_03,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0 suspectscore=0
 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205170101
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Sometimes dumping inside of a VM fails, is unavailable or doesn't
yield the required data. For these occasions we dump the VM from the
outside, writing memory and cpu data to a file.

Up to now PV guests only supported dumping from the inside of the
guest through dumpers like KDUMP. A PV guest can be dumped from the
hypervisor but the data will be stale and / or encrypted.

To get the actual state of the PV VM we need the help of the
Ultravisor who safeguards the VM state. New UV calls have been added
to initialize the dump, dump storage state data, dump cpu data and
complete the dump process. We expose these calls in this patch via a
new UV ioctl command.

The sensitive parts of the dump data are encrypted, the dump key is
derived from the Customer Communication Key (CCK). This ensures that
only the owner of the VM who has the CCK can decrypt the dump data.

The memory is dumped / read via a normal export call and a re-import
after the dump initialization is not needed (no re-encryption with a
dump key).

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |   1 +
 arch/s390/kvm/kvm-s390.c         |  93 ++++++++++++++++
 arch/s390/kvm/kvm-s390.h         |   4 +
 arch/s390/kvm/pv.c               | 183 +++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h         |  15 +++
 5 files changed, 296 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 766028d54a3e..a0fbe4820e0a 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -923,6 +923,7 @@ struct kvm_s390_pv {
 	u64 guest_len;
 	unsigned long stor_base;
 	void *stor_var;
+	bool dumping;
 };
 
 struct kvm_arch{
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 3cfaaa5994e1..24b8ac61efff 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2271,6 +2271,68 @@ static ssize_t kvm_s390_handle_pv_info(struct kvm_s390_pv_info *info)
 	}
 }
 
+static int kvm_s390_pv_dmp(struct kvm *kvm, struct kvm_pv_cmd *cmd,
+			   struct kvm_s390_pv_dmp dmp)
+{
+	int r = -EINVAL;
+	void __user *result_buff = (void __user *)dmp.buff_addr;
+
+	switch (dmp.subcmd) {
+	case KVM_PV_DUMP_INIT: {
+		if (kvm->arch.pv.dumping)
+			break;
+
+		/*
+		 * Block SIE entry as concurrent dump UVCs could lead
+		 * to validities.
+		 */
+		kvm_s390_vcpu_block_all(kvm);
+
+		r = uv_cmd_nodata(kvm_s390_pv_get_handle(kvm),
+				  UVC_CMD_DUMP_INIT, &cmd->rc, &cmd->rrc);
+		KVM_UV_EVENT(kvm, 3, "PROTVIRT DUMP INIT: rc %x rrc %x",
+			     cmd->rc, cmd->rrc);
+		if (!r) {
+			kvm->arch.pv.dumping = true;
+		} else {
+			kvm_s390_vcpu_unblock_all(kvm);
+			r = -EINVAL;
+		}
+		break;
+	}
+	case KVM_PV_DUMP_CONFIG_STOR_STATE: {
+		if (!kvm->arch.pv.dumping)
+			break;
+
+		/*
+		 * gaddr is an output parameter since we might stop
+		 * early. As dmp will be copied back in our caller, we
+		 * don't need to do it ourselves.
+		 */
+		r = kvm_s390_pv_dump_stor_state(kvm, result_buff, &dmp.gaddr, dmp.buff_len,
+						&cmd->rc, &cmd->rrc);
+		break;
+	}
+	case KVM_PV_DUMP_COMPLETE: {
+		if (!kvm->arch.pv.dumping)
+			break;
+
+		r = -EINVAL;
+		if (dmp.buff_len < uv_info.conf_dump_finalize_len)
+			break;
+
+		r = kvm_s390_pv_dump_complete(kvm, result_buff,
+					      &cmd->rc, &cmd->rrc);
+		break;
+	}
+	default:
+		r = -ENOTTY;
+		break;
+	}
+
+	return r;
+}
+
 static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
 {
 	int r = 0;
@@ -2447,6 +2509,28 @@ static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
 		r = 0;
 		break;
 	}
+	case KVM_PV_DUMP: {
+		struct kvm_s390_pv_dmp dmp;
+
+		r = -EINVAL;
+		if (!kvm_s390_pv_is_protected(kvm))
+			break;
+
+		r = -EFAULT;
+		if (copy_from_user(&dmp, argp, sizeof(dmp)))
+			break;
+
+		r = kvm_s390_pv_dmp(kvm, cmd, dmp);
+		if (r)
+			break;
+
+		if (copy_to_user(argp, &dmp, sizeof(dmp))) {
+			r = -EFAULT;
+			break;
+		}
+
+		break;
+	}
 	default:
 		r = -ENOTTY;
 	}
@@ -4555,6 +4639,15 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	struct kvm_run *kvm_run = vcpu->run;
 	int rc;
 
+	/*
+	 * Running a VM while dumping always has the potential to
+	 * produce inconsistent dump data. But for PV vcpus a SIE
+	 * entry while dumping could also lead to a fatal validity
+	 * intercept which we absolutely want to avoid.
+	 */
+	if (vcpu->kvm->arch.pv.dumping)
+		return -EINVAL;
+
 	if (kvm_run->immediate_exit)
 		return -EINTR;
 
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 497d52a83c78..2c11eb5ba3ef 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -250,6 +250,10 @@ int kvm_s390_pv_set_sec_parms(struct kvm *kvm, void *hdr, u64 length, u16 *rc,
 int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned long size,
 		       unsigned long tweak, u16 *rc, u16 *rrc);
 int kvm_s390_pv_set_cpu_state(struct kvm_vcpu *vcpu, u8 state);
+int kvm_s390_pv_dump_stor_state(struct kvm *kvm, void __user *buff_user,
+				u64 *gaddr, u64 buff_user_len, u16 *rc, u16 *rrc);
+int kvm_s390_pv_dump_complete(struct kvm *kvm, void __user *buff_user,
+			      u16 *rc, u16 *rrc);
 
 static inline u64 kvm_s390_pv_get_handle(struct kvm *kvm)
 {
diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index 7f7c0d6af2ce..52a67e2aaadd 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -7,6 +7,7 @@
  */
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
+#include <linux/minmax.h>
 #include <linux/pagemap.h>
 #include <linux/sched/signal.h>
 #include <asm/gmap.h>
@@ -303,3 +304,185 @@ int kvm_s390_pv_set_cpu_state(struct kvm_vcpu *vcpu, u8 state)
 		return -EINVAL;
 	return 0;
 }
+
+/* Size of the cache for the storage state dump data. 1MB for now */
+#define DUMP_BUFF_LEN HPAGE_SIZE
+
+/**
+ * kvm_s390_pv_dump_stor_state
+ *
+ * @kvm: pointer to the guest's KVM struct
+ * @buff_user: Userspace pointer where we will write the results to
+ * @gaddr: Starting absolute guest address for which the storage state
+ *         is requested.
+ * @buff_user_len: Length of the buff_user buffer
+ * @rc: Pointer to where the uvcb return code is stored
+ * @rrc: Pointer to where the uvcb return reason code is stored
+ *
+ * Stores buff_len bytes of tweak component values to buff_user
+ * starting with the 1MB block specified by the absolute guest address
+ * (gaddr). The gaddr pointer will be updated with the last address
+ * for which data was written when returning to userspace. buff_user
+ * might be written to even if an error rc is returned. For instance
+ * if we encounter a fault after writing the first page of data.
+ *
+ * Context: kvm->lock needs to be held
+ *
+ * Return:
+ *  0 on success
+ *  -ENOMEM if allocating the cache fails
+ *  -EINVAL if gaddr is not aligned to 1MB
+ *  -EINVAL if buff_user_len is not aligned to uv_info.conf_dump_storage_state_len
+ *  -EINVAL if the UV call fails, rc and rrc will be set in this case
+ *  -EFAULT if copying the result to buff_user failed
+ */
+int kvm_s390_pv_dump_stor_state(struct kvm *kvm, void __user *buff_user,
+				u64 *gaddr, u64 buff_user_len, u16 *rc, u16 *rrc)
+{
+	struct uv_cb_dump_stor_state uvcb = {
+		.header.cmd = UVC_CMD_DUMP_CONF_STOR_STATE,
+		.header.len = sizeof(uvcb),
+		.config_handle = kvm->arch.pv.handle,
+		.gaddr = *gaddr,
+		.dump_area_origin = 0,
+	};
+	const u64 increment_len = uv_info.conf_dump_storage_state_len;
+	size_t buff_kvm_size;
+	size_t size_done = 0;
+	u8 *buff_kvm = NULL;
+	int cc, ret;
+
+	ret = -EINVAL;
+	/* UV call processes 1MB guest storage chunks at a time */
+	if (!IS_ALIGNED(*gaddr, HPAGE_SIZE))
+		goto out;
+
+	/*
+	 * We provide the storage state for 1MB chunks of guest
+	 * storage. The buffer will need to be aligned to
+	 * conf_dump_storage_state_len so we don't end on a partial
+	 * chunk.
+	 */
+	if (!buff_user_len ||
+	    !IS_ALIGNED(buff_user_len, increment_len))
+		goto out;
+
+	/*
+	 * Allocate a buffer from which we will later copy to the user
+	 * process. We don't want userspace to dictate our buffer size
+	 * so we limit it to DUMP_BUFF_LEN.
+	 */
+	ret = -ENOMEM;
+	buff_kvm_size = min_t(u64, buff_user_len, DUMP_BUFF_LEN);
+	buff_kvm = vzalloc(buff_kvm_size);
+	if (!buff_kvm)
+		goto out;
+
+	ret = 0;
+	uvcb.dump_area_origin = (u64)buff_kvm;
+	/* We will loop until the user buffer is filled or an error occurs */
+	do {
+		/* Get 1MB worth of guest storage state data */
+		cc = uv_call_sched(0, (u64)&uvcb);
+
+		/* All or nothing */
+		if (cc) {
+			ret = -EINVAL;
+			break;
+		}
+
+		size_done += increment_len;
+		uvcb.dump_area_origin += increment_len;
+		buff_user_len -= increment_len;
+		uvcb.gaddr += HPAGE_SIZE;
+
+		/* KVM Buffer full, time to copy to the process */
+		if (!buff_user_len || size_done == DUMP_BUFF_LEN) {
+			if (copy_to_user(buff_user, buff_kvm, size_done)) {
+				ret = -EFAULT;
+				break;
+			}
+
+			buff_user += size_done;
+			size_done = 0;
+			uvcb.dump_area_origin = (u64)buff_kvm;
+		}
+	} while (buff_user_len);
+
+	/* Report back where we ended dumping */
+	*gaddr = uvcb.gaddr;
+
+	/* Lets only log errors, we don't want to spam */
+out:
+	if (ret)
+		KVM_UV_EVENT(kvm, 3,
+			     "PROTVIRT DUMP STORAGE STATE: addr %llx ret %d, uvcb rc %x rrc %x",
+			     uvcb.gaddr, ret, uvcb.header.rc, uvcb.header.rrc);
+	*rc = uvcb.header.rc;
+	*rrc = uvcb.header.rrc;
+	vfree(buff_kvm);
+
+	return ret;
+}
+
+/**
+ * kvm_s390_pv_dump_complete
+ *
+ * @kvm: pointer to the guest's KVM struct
+ * @buff_user: Userspace pointer where we will write the results to
+ * @rc: Pointer to where the uvcb return code is stored
+ * @rrc: Pointer to where the uvcb return reason code is stored
+ *
+ * Completes the dumping operation and writes the completion data to
+ * user space.
+ *
+ * Context: kvm->lock needs to be held
+ *
+ * Return:
+ *  0 on success
+ *  -ENOMEM if allocating the completion buffer fails
+ *  -EINVAL if the UV call fails, rc and rrc will be set in this case
+ *  -EFAULT if copying the result to buff_user failed
+ */
+int kvm_s390_pv_dump_complete(struct kvm *kvm, void __user *buff_user,
+			      u16 *rc, u16 *rrc)
+{
+	struct uv_cb_dump_complete complete = {
+		.header.len = sizeof(complete),
+		.header.cmd = UVC_CMD_DUMP_COMPLETE,
+		.config_handle = kvm_s390_pv_get_handle(kvm),
+	};
+	u64 *compl_data;
+	int ret;
+
+	/* Allocate dump area */
+	ret = -ENOMEM;
+	compl_data = vzalloc(uv_info.conf_dump_finalize_len);
+	if (!compl_data)
+		return ret;
+	complete.dump_area_origin = (u64)compl_data;
+
+	ret = uv_call_sched(0, (u64)&complete);
+	*rc = complete.header.rc;
+	*rrc = complete.header.rrc;
+	KVM_UV_EVENT(kvm, 3, "PROTVIRT DUMP COMPLETE: rc %x rrc %x",
+		     complete.header.rc, complete.header.rrc);
+
+	if (!ret) {
+		/*
+		 * kvm_s390_pv_dealloc_vm() will also (mem)set
+		 * this to false on a reboot or other destroy
+		 * operation for this vm.
+		 */
+		kvm->arch.pv.dumping = false;
+		kvm_s390_vcpu_unblock_all(kvm);
+		ret = copy_to_user(buff_user, compl_data, uv_info.conf_dump_finalize_len);
+		if (ret)
+			ret = -EFAULT;
+	}
+	vfree(compl_data);
+	/* If the UVC returned an error, translate it to -EINVAL */
+	if (ret > 0)
+		ret = -EINVAL;
+	return ret;
+}
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 2eba89d7ec29..b34850907291 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1645,6 +1645,20 @@ struct kvm_s390_pv_unp {
 	__u64 tweak;
 };
 
+enum pv_cmd_dmp_id {
+	KVM_PV_DUMP_INIT,
+	KVM_PV_DUMP_CONFIG_STOR_STATE,
+	KVM_PV_DUMP_COMPLETE,
+};
+
+struct kvm_s390_pv_dmp {
+	__u64 subcmd;
+	__u64 buff_addr;
+	__u64 buff_len;
+	__u64 gaddr;		/* For dump storage state */
+	__u64 reserved[4];
+};
+
 enum pv_cmd_info_id {
 	KVM_PV_INFO_VM,
 	KVM_PV_INFO_DUMP,
@@ -1688,6 +1702,7 @@ enum pv_cmd_id {
 	KVM_PV_PREP_RESET,
 	KVM_PV_UNSHARE_ALL,
 	KVM_PV_INFO,
+	KVM_PV_DUMP,
 };
 
 struct kvm_pv_cmd {
-- 
2.34.1

