Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 399A17DB75
	for <lists+linux-s390@lfdr.de>; Thu,  1 Aug 2019 14:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfHAM3C (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 1 Aug 2019 08:29:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6954 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728800AbfHAM3C (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Aug 2019 08:29:02 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71CSt5t084616
        for <linux-s390@vger.kernel.org>; Thu, 1 Aug 2019 08:29:01 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u3yseh3xq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 01 Aug 2019 08:29:00 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 1 Aug 2019 13:28:56 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 1 Aug 2019 13:28:53 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71CSpCO32637432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 12:28:51 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59FDEA405B;
        Thu,  1 Aug 2019 12:28:51 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EFABA4067;
        Thu,  1 Aug 2019 12:28:51 +0000 (GMT)
Received: from osiris (unknown [9.152.212.134])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  1 Aug 2019 12:28:50 +0000 (GMT)
Date:   Thu, 1 Aug 2019 14:28:49 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
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
 <20190731111520.GC3488@osiris>
 <20190731113216.GA21068@gondor.apana.org.au>
 <20190731114453.GD3488@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731114453.GD3488@osiris>
X-TM-AS-GCONF: 00
x-cbid: 19080112-4275-0000-0000-00000352BFAA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080112-4276-0000-0000-00003863B24B
Message-Id: <20190801122849.GB4163@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010131
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jul 31, 2019 at 01:44:54PM +0200, Heiko Carstens wrote:
> On Wed, Jul 31, 2019 at 09:32:16PM +1000, Herbert Xu wrote:
> > On Wed, Jul 31, 2019 at 01:15:20PM +0200, Heiko Carstens wrote:
> > >
> > > However that doesn't fix the simd.h header file breakage with the
> > > second patch :)
> > 
> > That fix should be there now too.
> 
> Yes, works now. Thank you!

Still not... with linux-next as of today I get this (s390 defconfig):

ERROR: "crypto_aegis128_decrypt_chunk_simd" [crypto/aegis128.ko] undefined!
ERROR: "crypto_aegis128_update_simd" [crypto/aegis128.ko] undefined!
ERROR: "crypto_aegis128_encrypt_chunk_simd" [crypto/aegis128.ko] undefined!
scripts/Makefile.modpost:105: recipe for target 'modules-modpost' failed

