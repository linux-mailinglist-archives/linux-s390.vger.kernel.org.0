Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD7637BF07
	for <lists+linux-s390@lfdr.de>; Wed, 31 Jul 2019 13:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfGaLPa (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 31 Jul 2019 07:15:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19362 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726561AbfGaLP3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 31 Jul 2019 07:15:29 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6VBDHro130675
        for <linux-s390@vger.kernel.org>; Wed, 31 Jul 2019 07:15:29 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u395at82s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 31 Jul 2019 07:15:28 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Wed, 31 Jul 2019 12:15:26 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 31 Jul 2019 12:15:23 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6VBF56l33554876
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 11:15:05 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7BCB11C05E;
        Wed, 31 Jul 2019 11:15:21 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DFEB11C050;
        Wed, 31 Jul 2019 11:15:21 +0000 (GMT)
Received: from osiris (unknown [9.152.212.134])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 31 Jul 2019 11:15:21 +0000 (GMT)
Date:   Wed, 31 Jul 2019 13:15:20 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390@vger.kernel.org,
        Harald Freudenberger <freude@linux.ibm.com>,
        Patrick Steuer <steuer@linux.ibm.com>
Subject: Re: linux-next: Tree for Jul 31 - s390 crypto build breakage
References: <20190731163915.3fdfcb14@canb.auug.org.au>
 <20190731085819.GA3488@osiris>
 <20190731110816.GA20753@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731110816.GA20753@gondor.apana.org.au>
X-TM-AS-GCONF: 00
x-cbid: 19073111-0012-0000-0000-00000337F6EE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19073111-0013-0000-0000-000021719FB9
Message-Id: <20190731111520.GC3488@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907310117
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jul 31, 2019 at 09:08:17PM +1000, Herbert Xu wrote:
> On Wed, Jul 31, 2019 at 10:58:20AM +0200, Heiko Carstens wrote:
> > On Wed, Jul 31, 2019 at 04:39:15PM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Changes since 20190730:
> > 
> > Hello Ard,
> > 
> > two of your patches in the crypto tree cause build breakage on s390:
> > 
> > The patch ("crypto: aes - create AES library based on the fixed time AES code")
> > causes this:
> 
> Ard already sent a patch for this which I've just pushed out.

Ok, thanks!

However that doesn't fix the simd.h header file breakage with the
second patch :)

