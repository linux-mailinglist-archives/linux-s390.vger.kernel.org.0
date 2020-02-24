Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D46116A7BE
	for <lists+linux-s390@lfdr.de>; Mon, 24 Feb 2020 14:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbgBXN4s (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 24 Feb 2020 08:56:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727460AbgBXN4s (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 24 Feb 2020 08:56:48 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01ODu6At019280
        for <linux-s390@vger.kernel.org>; Mon, 24 Feb 2020 08:56:47 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ybu12wr5s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 24 Feb 2020 08:56:44 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Mon, 24 Feb 2020 13:56:15 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 24 Feb 2020 13:56:10 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01ODu9Cv32571682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 13:56:09 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1746B52057;
        Mon, 24 Feb 2020 13:56:09 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.149])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9201452054;
        Mon, 24 Feb 2020 13:56:08 +0000 (GMT)
Date:   Mon, 24 Feb 2020 14:56:07 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
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
In-Reply-To: <08d6bdfb-9b49-c278-3c0b-2e02376cf0cf@redhat.com>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
        <426e6972-0565-c931-e171-da0f58fbf856@redhat.com>
        <20200221155602.4de41fa7.pasic@linux.ibm.com>
        <0181712c-e533-fcfd-2638-8a0649d713dd@redhat.com>
        <20200224010607-mutt-send-email-mst@kernel.org>
        <b3c52c67-c740-a50e-2595-fe04d179c881@redhat.com>
        <20200224024641-mutt-send-email-mst@kernel.org>
        <08d6bdfb-9b49-c278-3c0b-2e02376cf0cf@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022413-0008-0000-0000-00000355F424
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022413-0009-0000-0000-00004A770CC7
Message-Id: <20200224145607.2729f47b.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-24_04:2020-02-21,2020-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240115
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 24 Feb 2020 17:26:20 +0800
Jason Wang <jasowang@redhat.com> wrote:

> That's better.
> 
> How about attached?
> 
> Thanks

Thanks Jason! It does avoid the translation overhead in vhost.

Tested-by: Halil Pasic <pasic@linux.ibm.com>

Regarding the code, you fence it in virtio-net.c, but AFAIU this feature
has relevance for other vhost devices as well. E.g. what about vhost
user? Would it be the responsibility of each virtio device to fence this
on its own?

I'm also a bit confused about the semantics of the vhost feature bit
F_ACCESS_PLATFORM. What we have specified on virtio level is:
"""
This feature indicates that the device can be used on a platform where
device access to data in memory is limited and/or translated. E.g. this
is the case if the device can be located behind an IOMMU that translates
bus addresses from the device into physical addresses in memory, if the
device can be limited to only access certain memory addresses or if
special commands such as a cache flush can be needed to synchronise data
in memory with the device. Whether accesses are actually limited or
translated is described by platform-specific means. If this feature bit
is set to 0, then the device has same access to memory addresses
supplied to it as the driver has. In particular, the device will always
use physical addresses matching addresses used by the driver (typically
meaning physical addresses used by the CPU) and not translated further,
and can access any address supplied to it by the driver. When clear,
this overrides any platform-specific description of whether device
access is limited or translated in any way, e.g. whether an IOMMU may be
present.
"""

I read this like the addresses may be IOVAs which require
IMMU translation or GPAs which don't.

On the vhost level however, it seems that F_IOMMU_PLATFORM means that
vhost has to do the translation (via IOTLB API).

Do I understand this correctly? If yes, I believe we should document
this properly.

BTW I'm still not 100% on the purpose and semantics of the
F_ACCESS_PLATFORM feature bit. But that is a different problem.

Regards,
Halil

