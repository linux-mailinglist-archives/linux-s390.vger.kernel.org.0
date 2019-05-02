Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E99912111
	for <lists+linux-s390@lfdr.de>; Thu,  2 May 2019 19:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfEBReX (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 2 May 2019 13:34:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49120 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726412AbfEBReW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 May 2019 13:34:22 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x42HMfAt138457
        for <linux-s390@vger.kernel.org>; Thu, 2 May 2019 13:34:20 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s83w8302v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 02 May 2019 13:34:20 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 2 May 2019 18:34:18 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 2 May 2019 18:34:14 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x42HYCpF42533092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 May 2019 17:34:13 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D92B74C04A;
        Thu,  2 May 2019 17:34:12 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 479AE4C040;
        Thu,  2 May 2019 17:34:12 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.145.190.191])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  2 May 2019 17:34:12 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
Subject: [PATCH v8 0/4] vfio: ap: AP Queue Interrupt Control
Date:   Thu,  2 May 2019 19:34:07 +0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19050217-4275-0000-0000-00000330B6E2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050217-4276-0000-0000-0000384016EC
Message-Id: <1556818451-1806-1-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-02_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905020112
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This patch series implements PQAP/AQIC interception in KVM.

1) Data to handle GISA interrupt for AQIC

To implement this we need to add a new structure, vfio_ap_queue,
to be able to retrieve the mediated device associated with a queue
and specific values needed to register/unregister the interrupt
structures:
  - APQN: to be able to issue the commands and search for queue
    structures
  - saved NIB : to keep track of the pin page for unpining it
  - saved ISC : to unregister with the GIB interface
  - matrix_mdev: to retrieve the associate matrix, the mediated device
    and KVM

Specific handling bei keeping old values when re-registering is
needed because the guest could unregister interrupt in a invisble
manner bei issuing an un-interceptible RESET command.

Reset commands issued directly by the guest and indirectly when
removing the guest unpin the memory and deregister the ISC.

The vfio_ap_queue is associated to the ap_device during the probe
of the device and dissociated during the remove of the ap_device.

The vfio_ap_queue is associated to the matrix mediated device during
each interception of the AQIC command, so it does not need to be
dissociated until the guest is terminated.

The life of the vfio_ap_queue will be protected by the matrix_dev lock
to guaranty that no change can occur to the CRYCB or that devices can
not be removed when a vfio_ap_queue is in use.

2) KVM destroy race conditions

To make sure that KVM do not vanish and GISA is still available
when the VFIO_AP driver is in used we take a reference to KVM
during the opening of the mediated device and release it on
releasing the mediated device.

3) Interception of PQAP

The driver registers a hook structure to KVM providing:
- a pointer to a function implementing PQAP(AQIC) handling
- the reference to the module owner of the hook

On interception by KVM we do not change the behavior, returning
 -EOPNOTSUPP to the user in the case AP instructions are not
supported by the host or by the guest.
Otherwise we verify the exceptions cases before trying to call 
the vfio_ap hook.

In the case we do not find a hook we assume that the CRYCB has not
been setup for the guest and is empty.

4) Enabling and disabling the IRQ

When enabling the IRQ care is taken to unping the saved NIB.
When disabling IRQ care is taken to wait until the IRQ bit
of the queue status is cleared before unpining the NIB.

On RESET and before unpinning the NIB and unregistering the ISC
the IRQ is disabled using PQAP/AQIC even when a PQAP/APZQ have
been done.

5) Removing the AP device

Removing the AP device without having unassign it is clearly
discourage by the documentation.
The patch series does not check if the queue is used by a
guest. It only de-register the IRQ, unregister ISC and unpin
the NIB, then free the vfio_ap_queue.

6) Associated QEMU patch

There is a QEMU patch which is needed to enable the PQAP/AQIC
facility in the guest.

Posted in qemu-devel@nongnu.org as:
Message-Id: <1550146494-21085-1-git-send-email-pmorel@linux.ibm.com>



Pierre Morel (4):
  s390: ap: kvm: add PQAP interception for AQIC
  vfio: ap: register IOMMU VFIO notifier
  s390: ap: implement PAPQ AQIC interception in kernel
  s390: ap: kvm: Enable PQAP/AQIC facility for the guest

 arch/s390/include/asm/kvm_host.h      |   7 +
 arch/s390/kvm/priv.c                  |  86 +++++++++
 arch/s390/tools/gen_facilities.c      |   1 +
 drivers/s390/crypto/ap_bus.h          |   1 +
 drivers/s390/crypto/vfio_ap_drv.c     |  36 +++-
 drivers/s390/crypto/vfio_ap_ops.c     | 326 +++++++++++++++++++++++++++++++++-
 drivers/s390/crypto/vfio_ap_private.h |  15 ++
 7 files changed, 464 insertions(+), 8 deletions(-)

-- 
2.7.4

Changelog:

Changelog from v7:
- Modification of the IRQ disable routine to call ap_aqic
  even a ap_zapq has been done
  (to answer a question from Christian)
- use GISA origin instead of gisa next_alert field to
  initialize ap_aqic register 2
  (Halil)
- Corection of the testing of the vfio_pin_pages return value.
  (Halil)
- Only keep track of saved_isc and saved_pfn for a later 
  interrupt disabling.
  (Halil)
- renaming the routine to enable/disable the interruptions

Changelog from v6:
- Not taking care if the AP queue is associated with a guest
  admin is warn in the odcumentation
 (Tony, Halil)
- Using WARN_ON_ONCE, direct call to report specification errors
  (Christian)
- Wait until the IRQ bit is cleared when clearing interrupts
 (Tony, Halil)
- Some minor changes and add some comments before
  vfio_ap_free_irq_data
  (Pierre)
- initializing the pointer to matrix_mdev in vfio_ap_queue 
  during the interception and suppress the association during
  assignment and the usage of lists.
  (Tony, Halil)
- Merging patches for creation of vfio_ap_queue, initialization
  and use of vfio_ap_queue during interception of PQAP/AQIC
  (Conny)

Changelog from v5:
- Refactoring of the PQAP interception after all discussions
  (Conny, Halil (offline))
- take a big lock around open to avoid parallel changes through
  assignment
- verify that at least one queue has a APID or APQI when
  first assignment is done to not accept unavailable APID/APQI
  (myself)
- Adding comment for locks on free_list
  (Conny)
- Modified comment for 
  "s390: ap: setup relation betwen KVM and mediated device"
  (Halil)

Changelog from v4:
- Add forgotten locking for vfio_get_queue() in pqap callback
  (Conny / Halil)
- Add KVM reference counting to make sure GISA is free after IRQ
  (Christian / Halil)
- Take care that ISC = 0 is a valid ISC
  (Halil)
- Integrate the PQAP call back in a structure with module owner
  reference counting to make sure the callback does not disappear.
- Restrict functionality to always open KVM before opening the
  VFIO device.
- Search all devices in the vfio_ap driver list when associating
  a queue to a mediated device
  (Halil / Tony)
- Get vfio_ap_free_irq() out of vfio_ap_mdev_reset_queue() to call
  it always, whatever the result of the reset.
  (Tony)

Changelog from v3:
- Associating the vfio_queues during APID/APQI assign
  (Tony)
- Dissociating the vfio_queues during APID/APQI unassign
  (Tony)
- Taking care that the guest can directly disable the interrupt
  by using a RESET
  (Halil)
- Remove the patch creating the matrix bus to accelerate its
  integration in Linux stable
  (Christian)

Changelog from v1:
- Refactoring to handle interception in kernel instead of in
  QEMU
  (Halil)

