Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B74B1167EFF
	for <lists+linux-s390@lfdr.de>; Fri, 21 Feb 2020 14:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgBUNtr (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 21 Feb 2020 08:49:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19068 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727161AbgBUNtq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Feb 2020 08:49:46 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LDe4tH009076
        for <linux-s390@vger.kernel.org>; Fri, 21 Feb 2020 08:49:46 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yafh8t6e9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 21 Feb 2020 08:49:46 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 21 Feb 2020 13:49:43 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Feb 2020 13:49:39 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01LDncmK46792746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 13:49:38 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 182E942042;
        Fri, 21 Feb 2020 13:49:38 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 875A14203F;
        Fri, 21 Feb 2020 13:49:37 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.149])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Feb 2020 13:49:37 +0000 (GMT)
Date:   Fri, 21 Feb 2020 14:49:36 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
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
Subject: Re: [PATCH 0/2] virtio: decouple protected guest RAM form
 VIRTIO_F_IOMMU_PLATFORM
In-Reply-To: <20200220163055-mutt-send-email-mst@kernel.org>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
        <20200220163055-mutt-send-email-mst@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022113-4275-0000-0000-000003A42EE8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022113-4276-0000-0000-000038B83E39
Message-Id: <20200221144936.2102bcce.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_03:2020-02-19,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 mlxscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210106
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 20 Feb 2020 16:33:35 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Feb 20, 2020 at 05:06:04PM +0100, Halil Pasic wrote:
> > For vhost-net the feature VIRTIO_F_IOMMU_PLATFORM has the following side
> > effect The vhost code assumes it the addresses on the virtio descriptor
> > ring are not guest physical addresses but iova's, and insists on doing a
> > translation of these regardless of what transport is used (e.g. whether
> > we emulate a PCI or a CCW device). (For details see commit 6b1e6cc7855b
> > "vhost: new device IOTLB API".) On s390 this results in severe
> > performance degradation (c.a. factor 10). BTW with ccw I/O there is
> > (architecturally) no IOMMU, so the whole address translation makes no
> > sense in the context of virtio-ccw.
> 
> So it sounds like a host issue: the emulation of s390 unnecessarily complicated.
> Working around it by the guest looks wrong ...

While do think that forcing IOMMU_PLATFORM on devices that do not
want or need it, just to trigger DMA API usage in guest is conceptually
wrong, I do agree, that we might have a host issue. Namely, unlike PCI,
CCW does not have an IOMMU, and the spec clearly states that "Whether
accesses are actually limited or translated is described by
platform-specific means.". With CCW devices we don't have address translation
by IOMMU, and in that sense vhost is probably wrong about trying to do
the translation. That is why I mentioned the patch, and that it's done
regardless of the transport/platform.

Regards,
Halil


> 
> > Halil Pasic (2):
> >   mm: move force_dma_unencrypted() to mem_encrypt.h
> >   virtio: let virtio use DMA API when guest RAM is protected
> > 
> >  drivers/virtio/virtio_ring.c |  3 +++
> >  include/linux/dma-direct.h   |  9 ---------
> >  include/linux/mem_encrypt.h  | 10 ++++++++++
> >  3 files changed, 13 insertions(+), 9 deletions(-)
> > 
> > 
> > base-commit: ca7e1fd1026c5af6a533b4b5447e1d2f153e28f2
> > -- 
> > 2.17.1
> 

