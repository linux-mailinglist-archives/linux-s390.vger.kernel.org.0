Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 399691661DC
	for <lists+linux-s390@lfdr.de>; Thu, 20 Feb 2020 17:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgBTQIC (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 20 Feb 2020 11:08:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26772 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728529AbgBTQIC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 20 Feb 2020 11:08:02 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01KG575w129106
        for <linux-s390@vger.kernel.org>; Thu, 20 Feb 2020 11:08:01 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y99pg1eed-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 20 Feb 2020 11:08:00 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 20 Feb 2020 16:07:58 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Feb 2020 16:07:53 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01KG6bC651511464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 16:06:37 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E262AE055;
        Thu, 20 Feb 2020 16:06:37 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF0B3AE058;
        Thu, 20 Feb 2020 16:06:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 20 Feb 2020 16:06:36 +0000 (GMT)
From:   Halil Pasic <pasic@linux.ibm.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH 0/2] virtio: decouple protected guest RAM form VIRTIO_F_IOMMU_PLATFORM 
Date:   Thu, 20 Feb 2020 17:06:04 +0100
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 20022016-0016-0000-0000-000002E8A994
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022016-0017-0000-0000-0000334BC6D6
Message-Id: <20200220160606.53156-1-pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_04:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=969
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200118
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Currently if one intends to run a memory protection enabled VM with
virtio devices and linux as the guest OS, one needs to specify the
VIRTIO_F_IOMMU_PLATFORM flag for each virtio device to make the guest
linux use the DMA API, which in turn handles the memory
encryption/protection stuff if the guest decides to turn itself into
a protected one. This however makes no sense due to multiple reasons:
* The device is not changed by the fact that the guest RAM is
protected. The so called IOMMU bypass quirk is not affected.
* This usage is not congruent with  standardised semantics of
VIRTIO_F_IOMMU_PLATFORM. Guest memory protected is an orthogonal reason
for using DMA API in virtio (orthogonal with respect to what is
expressed by VIRTIO_F_IOMMU_PLATFORM). 

This series aims to decouple 'have to use DMA API because my (guest) RAM
is protected' and 'have to use DMA API because the device told me
VIRTIO_F_IOMMU_PLATFORM'.

Please find more detailed explanations about the conceptual aspects in
the individual patches. There is however also a very practical problem
that is addressed by this series. 

For vhost-net the feature VIRTIO_F_IOMMU_PLATFORM has the following side
effect The vhost code assumes it the addresses on the virtio descriptor
ring are not guest physical addresses but iova's, and insists on doing a
translation of these regardless of what transport is used (e.g. whether
we emulate a PCI or a CCW device). (For details see commit 6b1e6cc7855b
"vhost: new device IOTLB API".) On s390 this results in severe
performance degradation (c.a. factor 10). BTW with ccw I/O there is
(architecturally) no IOMMU, so the whole address translation makes no
sense in the context of virtio-ccw.

Halil Pasic (2):
  mm: move force_dma_unencrypted() to mem_encrypt.h
  virtio: let virtio use DMA API when guest RAM is protected

 drivers/virtio/virtio_ring.c |  3 +++
 include/linux/dma-direct.h   |  9 ---------
 include/linux/mem_encrypt.h  | 10 ++++++++++
 3 files changed, 13 insertions(+), 9 deletions(-)


base-commit: ca7e1fd1026c5af6a533b4b5447e1d2f153e28f2
-- 
2.17.1

