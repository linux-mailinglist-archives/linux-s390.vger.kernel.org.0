Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACD8C6CD6F
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jul 2019 13:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfGRLgq (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 18 Jul 2019 07:36:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18088 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726495AbfGRLgq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 18 Jul 2019 07:36:46 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6IBahMk086508
        for <linux-s390@vger.kernel.org>; Thu, 18 Jul 2019 07:36:45 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ttp2y53t5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 18 Jul 2019 07:36:45 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 18 Jul 2019 12:36:38 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 18 Jul 2019 12:36:36 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6IBaYn136765998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 11:36:34 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C18C7A405C;
        Thu, 18 Jul 2019 11:36:34 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B534A4054;
        Thu, 18 Jul 2019 11:36:34 +0000 (GMT)
Received: from osiris (unknown [9.152.212.134])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 18 Jul 2019 11:36:34 +0000 (GMT)
Date:   Thu, 18 Jul 2019 13:36:33 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Petr Tesarik <ptesarik@suse.cz>
Cc:     linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: Is __dma_direct_alloc_pages broken on s390?
References: <20190718091700.353b3721@ezekiel.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718091700.353b3721@ezekiel.suse.cz>
X-TM-AS-GCONF: 00
x-cbid: 19071811-0008-0000-0000-000002FEA63B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071811-0009-0000-0000-0000226C241F
Message-Id: <20190718113633.GB3581@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=628 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180126
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jul 18, 2019 at 09:17:00AM +0200, Petr Tesarik wrote:
> Hi all,
> 
> while looking into DMA allocation, I noticed that
> __dma_direct_optimal_gfp_mask() in kernel/dma/direct.c can probably be
> improved. It uses GFP_DMA if dev->coherent_dma_mask is less than
> DMA_BIT_MASK(ARCH_ZONE_DMA_BITS). There is no s390-specific definition
> of ARCH_ZONE_DMA_BITS. The default is 24 bits, but the DMA zone on s390
> is 31 bits. CCW subchannel devices set sch->dev.coherent_dma_mask to
> DMA_BIT_MASK(31), which is greater than DMA_BIT_MASK(24), so buffers
> are allocated from the Normal zone first.
> 
> Would it make sense to set ARCH_ZONE_BITS to 31 on s390, or did I miss
> something?

No, this seems to be broken. Halil, can you look into this and provide
a patch?

