Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06A43DA7EB
	for <lists+linux-s390@lfdr.de>; Thu, 17 Oct 2019 11:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408432AbfJQJAl (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 17 Oct 2019 05:00:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59160 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405313AbfJQJAl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Oct 2019 05:00:41 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9H8x9mS059161
        for <linux-s390@vger.kernel.org>; Thu, 17 Oct 2019 05:00:40 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vpkcvm14v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 17 Oct 2019 05:00:40 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 17 Oct 2019 10:00:37 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 17 Oct 2019 10:00:36 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9H90YtO22937850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 09:00:35 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1F2CAE068;
        Thu, 17 Oct 2019 09:00:34 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90A4AAE045;
        Thu, 17 Oct 2019 09:00:34 +0000 (GMT)
Received: from osiris (unknown [9.152.212.85])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 17 Oct 2019 09:00:34 +0000 (GMT)
Date:   Thu, 17 Oct 2019 11:00:33 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>
Subject: Re: [RFT PATCH 0/3] crypto: s390 - convert to skcipher API
References: <20191012201809.160500-1-ebiggers@kernel.org>
 <20191016080103.GA4267@osiris>
 <20191016123507.GA16265@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016123507.GA16265@gondor.apana.org.au>
X-TM-AS-GCONF: 00
x-cbid: 19101709-4275-0000-0000-00000372E389
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101709-4276-0000-0000-00003885FB5E
Message-Id: <20191017090033.GA6087@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=904 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910170081
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Oct 16, 2019 at 11:35:07PM +1100, Herbert Xu wrote:
> > > Eric Biggers (3):
> > >   crypto: s390/aes - convert to skcipher API
> > >   crypto: s390/paes - convert to skcipher API
> > >   crypto: s390/des - convert to skcipher API
> > > 
> > >  arch/s390/crypto/aes_s390.c  | 609 ++++++++++++++---------------------
> > >  arch/s390/crypto/des_s390.c  | 419 ++++++++++--------------
> > >  arch/s390/crypto/paes_s390.c | 414 ++++++++++--------------
> > >  3 files changed, 580 insertions(+), 862 deletions(-)
> > 
> > Herbert, should these go upstream via the s390 or crypto tree?
> 
> It would be best to go via the crypto tree since any future patches
> to remove blkcipher/ablkcipher would depend on these patches.

Ok, fully agreed. Thanks!

