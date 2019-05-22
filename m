Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B348227213
	for <lists+linux-s390@lfdr.de>; Thu, 23 May 2019 00:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfEVWM5 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 22 May 2019 18:12:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46176 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726070AbfEVWM4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 22 May 2019 18:12:56 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4MMC6Cr005424
        for <linux-s390@vger.kernel.org>; Wed, 22 May 2019 18:12:55 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sneqtrk8x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 22 May 2019 18:12:54 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Wed, 22 May 2019 23:12:53 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 May 2019 23:12:51 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4MMCn4540632524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 May 2019 22:12:49 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24EBCA4062;
        Wed, 22 May 2019 22:12:49 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DF54A4054;
        Wed, 22 May 2019 22:12:48 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.34.240])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 May 2019 22:12:48 +0000 (GMT)
Date:   Thu, 23 May 2019 00:12:46 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Sebastian Ott <sebott@linux.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Huth <thuth@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH 05/10] s390/cio: introduce DMA pools to cio
In-Reply-To: <alpine.LFD.2.21.1905221344180.1782@schleppi>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
        <20190426183245.37939-6-pasic@linux.ibm.com>
        <alpine.LFD.2.21.1905081447280.1773@schleppi>
        <20190508232210.5a555caa.pasic@linux.ibm.com>
        <20190509121106.48aa04db.cohuck@redhat.com>
        <20190510001112.479b2fd7.pasic@linux.ibm.com>
        <20190510161013.7e697337.cohuck@redhat.com>
        <20190512202256.5517592d.pasic@linux.ibm.com>
        <alpine.LFD.2.21.1905161517570.1767@schleppi>
        <20190520141312.4e3a2d36.pasic@linux.ibm.com>
        <alpine.LFD.2.21.1905221344180.1782@schleppi>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19052222-0016-0000-0000-0000027E7824
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052222-0017-0000-0000-000032DB6C00
Message-Id: <20190523001246.449154aa.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-22_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905220154
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 22 May 2019 14:07:05 +0200 (CEST)
Sebastian Ott <sebott@linux.ibm.com> wrote:

> On Mon, 20 May 2019, Halil Pasic wrote:
> > On Thu, 16 May 2019 15:59:22 +0200 (CEST)
> > Sebastian Ott <sebott@linux.ibm.com> wrote:
> > > We only have a couple of users for airq_iv:
> > > 
> > > virtio_ccw.c: 2K bits
> > 
> > You mean a single allocation is 2k bits (VIRTIO_IV_BITS = 256 * 8)? My
> > understanding is that the upper bound is more like:
> > MAX_AIRQ_AREAS * VIRTIO_IV_BITS = 20 * 256 * 8 = 40960 bits.
> > 
> > In practice it is most likely just 2k.
> > 
> > > 
> > > pci with floating IRQs: <= 2K (for the per-function bit vectors)
> > >                         1..4K (for the summary bit vector)
> > >
> > 
> > As far as I can tell with virtio_pci arch_setup_msi_irqs() gets called
> > once per device and allocates a small number of bits (2 and 3 in my
> > test, it may depend on #virtqueues, but I did not check).
> > 
> > So for an upper bound we would have to multiply with the upper bound of
> > pci devices/functions. What is the upper bound on the number of
> > functions?
> > 
> > > pci with CPU directed IRQs: 2K (for the per-CPU bit vectors)
> > >                             1..nr_cpu (for the summary bit vector)
> > > 
> > 
> > I guess this is the same.
> > 
> > > 
> > > The options are:
> > > * page allocations for everything
> > 
> > Worst case we need 20 + #max_pci_dev pages. At the moment we allocate
> > from ZONE_DMA (!) and waste a lot.
> > 
> > > * dma_pool for AIRQ_IV_CACHELINE ,gen_pool for others
> > 
> > I prefer this. Explanation follows.
> > 
> > > * dma_pool for everything
> > > 
> > 
> > Less waste by factor factor 16.
> > 
> > > I think we should do option 3 and use a dma_pool with cachesize
> > > alignment for everything (as a prerequisite we have to limit
> > > config PCI_NR_FUNCTIONS to 2K - but that is not a real constraint).
> > 
> > I prefer option 3 because it is conceptually the smallest change, and
>                   ^
>                   2
> > provides the behavior which is closest to the current one.
> 
> I can see that this is the smallest change on top of the current
> implementation. I'm good with doing that and looking for further
> simplification/unification later.
> 

Nod. I will go with that for v2.

> 
> > Commit  414cbd1e3d14 "s390/airq: provide cacheline aligned
> > ivs" (Sebastian Ott, 2019-02-27) could have been smaller had you implemented
> > 'kmem_cache for everything' (and I would have had just to replace kmem_cache with
> > dma_cache to achieve option 3). For some reason you decided to keep the
> > iv->vector = kzalloc(size, GFP_KERNEL) code-path and make the client code request
> > iv->vector = kmem_cache_zalloc(airq_iv_cache, GFP_KERNEL) explicitly, using a flag
> > which you only decided to use for directed pci irqs AFAICT.
> > 
> > My understanding of these decisions, and especially of the rationale
> > behind commit 414cbd1e3d14 is limited.
> 
> I introduced per cpu interrupt vectors and wanted to prevent 2 CPUs from
> sharing data from the same cacheline. No other user of the airq stuff had
> this need. If I had been aware of the additional complexity we would add
> on top of that maybe I would have made a different decision.

I understand. Thanks for the explanation!

Regards,
Halil

