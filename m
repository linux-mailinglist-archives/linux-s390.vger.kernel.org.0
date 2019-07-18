Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 663396CFA4
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jul 2019 16:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfGRO1n (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 18 Jul 2019 10:27:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12132 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727730AbfGRO1n (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 18 Jul 2019 10:27:43 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6IEJCuv095322
        for <linux-s390@vger.kernel.org>; Thu, 18 Jul 2019 10:27:42 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tts6vm9gv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 18 Jul 2019 10:27:42 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 18 Jul 2019 15:27:40 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 18 Jul 2019 15:27:38 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6IERbNw38797820
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 14:27:37 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D3365204E;
        Thu, 18 Jul 2019 14:27:37 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.219])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E62A552052;
        Thu, 18 Jul 2019 14:27:36 +0000 (GMT)
Date:   Thu, 18 Jul 2019 16:27:35 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Petr Tesarik <ptesarik@suse.cz>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: Is __dma_direct_alloc_pages broken on s390?
In-Reply-To: <20190718131059.GA18742@infradead.org>
References: <20190718091700.353b3721@ezekiel.suse.cz>
        <20190718113633.GB3581@osiris>
        <20190718135112.5c65685f@ezekiel.suse.cz>
        <20190718145044.03dc9804.pasic@linux.ibm.com>
        <20190718131059.GA18742@infradead.org>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19071814-0028-0000-0000-00000385BB13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071814-0029-0000-0000-00002445E535
Message-Id: <20190718162735.1559b561.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=906 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180149
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 18 Jul 2019 06:10:59 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Thu, Jul 18, 2019 at 02:50:44PM +0200, Halil Pasic wrote:
> > > I wondered why the kernel works OK on my system, and it is in fact not
> > > so bad. If the first allocation fails, the kernel adds GFP_DMA and
> > > retries, so this is not fatal, but with a proper definition of
> > > ARCH_ZONE_DMA_BITS it should be possible to get success in the first
> > > attempt already, let's do it.
> > > 
> > > Petr T
> > 
> > I fully agree! I will post a patch that provides correct
> > ARCH_ZONE_DMA_BITS for s390.
> > 
> > BTW I wonder if ARCH_ZONE_DMA_BITS can be inferred from MAX_DMA_ADDRESS,
> > and why do we need both.@Christoph, maybe you can help me understand if
> > there is a relationship between the two or not, or?
> 
> MAX_DMA_ADDRESS is a bit of a weird beast which I honestly do not
> understand fully, but most of the uses in common code look a little
> bogus, and we should probably get rid of it.

Thanks!

Regards,
Halil

