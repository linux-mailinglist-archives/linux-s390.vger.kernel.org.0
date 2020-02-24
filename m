Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59EB116A521
	for <lists+linux-s390@lfdr.de>; Mon, 24 Feb 2020 12:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgBXLlY (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 24 Feb 2020 06:41:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15042 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727185AbgBXLlS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 24 Feb 2020 06:41:18 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01OBdhoR094583;
        Mon, 24 Feb 2020 06:41:17 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yax44adcu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Feb 2020 06:41:16 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01OBdhES094620;
        Mon, 24 Feb 2020 06:41:16 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yax44adch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Feb 2020 06:41:16 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01OBcGmk018396;
        Mon, 24 Feb 2020 11:41:15 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03wdc.us.ibm.com with ESMTP id 2yaux6331d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Feb 2020 11:41:15 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01OBfDbG46792960
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 11:41:13 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D5EC2805C;
        Mon, 24 Feb 2020 11:41:13 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7473C28059;
        Mon, 24 Feb 2020 11:41:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.114.17.106])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 24 Feb 2020 11:41:13 +0000 (GMT)
From:   Christian Borntraeger <borntraeger@de.ibm.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.vnet.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Thomas Huth <thuth@redhat.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Michael Mueller <mimu@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v4 36/36] KVM: s390: protvirt: Add KVM api documentation
Date:   Mon, 24 Feb 2020 06:41:07 -0500
Message-Id: <20200224114107.4646-37-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224114107.4646-1-borntraeger@de.ibm.com>
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-24_02:2020-02-21,2020-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240099
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Janosch Frank <frankja@linux.ibm.com>

Add documentation for KVM_CAP_S390_PROTECTED capability and the
KVM_S390_PV_COMMAND ioctl.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virt/kvm/api.rst | 55 ++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 7505d7a6c0d8..20abb8b2594e 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -4648,6 +4648,51 @@ the clear cpu reset definition in the POP. However, the cpu is not put
 into ESA mode. This reset is a superset of the initial reset.
 
 
+4.125 KVM_S390_PV_COMMAND
+-------------------------
+
+:Capability: KVM_CAP_S390_PROTECTED
+:Architectures: s390
+:Type: vm ioctl
+:Parameters: struct kvm_pv_cmd
+:Returns: 0 on success, < 0 on error
+
+::
+
+  struct kvm_pv_cmd {
+	__u32 cmd;	/* Command to be executed */
+	__u16 rc;	/* Ultravisor return code */
+	__u16 rrc;	/* Ultravisor return reason code */
+	__u64 data;	/* Data or address */
+	__u32 flags;    /* flags for future extensions. Must be 0 for now */
+	__u32 reserved[3];
+  };
+
+cmd values:
+
+KVM_PV_ENABLE
+  Allocate memory and register the VM with the Ultravisor, thereby
+  donating memory to the Ultravisor making it inaccessible to KVM.
+  Also converts all existing CPUs to protected ones. Future hotplug
+  CPUs will become protected during creation.
+
+KVM_PV_DISABLE
+  Deregisters the VM from the Ultravisor and frees memory that was
+  donated, so the kernel can use it again. All registered VCPUs are
+  converted back to non-protected ones.
+
+KVM_PV_VM_SET_SEC_PARMS
+  Pass the image header from VM memory to the Ultravisor in
+  preparation of image unpacking and verification.
+
+KVM_PV_VM_UNPACK
+  Unpack (protect and decrypt) a page of the encrypted boot image.
+
+KVM_PV_VM_VERIFY
+  Verify the integrity of the unpacked image. Only if this succeeds,
+  KVM is allowed to start protected VCPUs.
+
+
 5. The kvm_run structure
 ========================
 
@@ -6026,3 +6071,13 @@ Architectures: s390
 
 This capability indicates that the KVM_S390_NORMAL_RESET and
 KVM_S390_CLEAR_RESET ioctls are available.
+
+8.23 KVM_CAP_S390_PROTECTED
+
+Architecture: s390
+
+This capability indicates that KVM can start protected VMs and the
+Ultravisor has therefore been initialized.
+This will provide the new KVM_S390_PV_COMMAND ioctl and it will allow
+KVM_MP_STATE_LOAD as new MP_STATE. KVM_SET_MP_STATE can now fail for
+protected guests when the state change is invalid.
-- 
2.25.0

