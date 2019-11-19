Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEDB21022A7
	for <lists+linux-s390@lfdr.de>; Tue, 19 Nov 2019 12:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfKSLKd (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 19 Nov 2019 06:10:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41812 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725904AbfKSLKc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 Nov 2019 06:10:32 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAJB85DU058966
        for <linux-s390@vger.kernel.org>; Tue, 19 Nov 2019 06:10:31 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wcf5m8hwe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 19 Nov 2019 06:10:31 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Tue, 19 Nov 2019 11:10:29 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Nov 2019 11:10:25 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAJBAOfh45744278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 11:10:24 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A019DAE06C;
        Tue, 19 Nov 2019 11:10:23 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39272AE061;
        Tue, 19 Nov 2019 11:10:23 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.42])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 19 Nov 2019 11:10:23 +0000 (GMT)
Date:   Tue, 19 Nov 2019 12:10:22 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org,
        Michael Mueller <mimu@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/1] virtio_ring: fix return code on DMA mapping fails
In-Reply-To: <20191114124646.74790-1-pasic@linux.ibm.com>
References: <20191114124646.74790-1-pasic@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111911-0012-0000-0000-00000367F12E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111911-0013-0000-0000-000021A37ACA
Message-Id: <20191119121022.03aed69a.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_03:2019-11-15,2019-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911190105
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

ping

On Thu, 14 Nov 2019 13:46:46 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> Commit 780bc7903a32 ("virtio_ring: Support DMA APIs")  makes
> virtqueue_add() return -EIO when we fail to map our I/O buffers. This is
> a very realistic scenario for guests with encrypted memory, as swiotlb
> may run out of space, depending on it's size and the I/O load.
> 
> The virtio-blk driver interprets -EIO form virtqueue_add() as an IO
> error, despite the fact that swiotlb full is in absence of bugs a
> recoverable condition.
> 
> Let us change the return code to -ENOMEM, and make the block layer
> recover form these failures when virtio-blk encounters the condition
> described above.
> 
> Fixes: 780bc7903a32 ("virtio_ring: Support DMA APIs")
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> ---
> 
> Notes
> =====
> 
> * When out of descriptors (which might regarded as a similar out of
> resources condition) virtio uses -ENOSPC, this however seems wrong,
> as ENOSPC is defined as -ENOSPC. Thus I choose -ENOMEM over -ENOSPC.
> 
> * In virtio_queue_rq() in virtio_blk.c both -ENOMEM and -ENOSPC are
> handled as BLK_STS_DEV_RESOURCE. Returning BLK_STS_RESOURCE however
> seems more appropriate for dma mapping failed as we are talking about
> a global, and not a device local resource. Both seem to do the trick.
> 
> * Mimu tested the patch with virtio-blk and virtio-net (thanks!). We
> should look into how other virtio devices behave when DMA mapping fails.
> ---
>  drivers/virtio/virtio_ring.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index a8041e451e9e..867c7ebd3f10 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -583,7 +583,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  		kfree(desc);
>  
>  	END_USE(vq);
> -	return -EIO;
> +	return -ENOMEM;
>  }
>  
>  static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
> @@ -1085,7 +1085,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	kfree(desc);
>  
>  	END_USE(vq);
> -	return -EIO;
> +	return -ENOMEM;
>  }
>  
>  static inline int virtqueue_add_packed(struct virtqueue *_vq,

