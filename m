Return-Path: <linux-s390+bounces-535-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA2781070B
	for <lists+linux-s390@lfdr.de>; Wed, 13 Dec 2023 01:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 041F3B20E60
	for <lists+linux-s390@lfdr.de>; Wed, 13 Dec 2023 00:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2BAA41;
	Wed, 13 Dec 2023 00:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ao/jdpu2"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A21CA0;
	Tue, 12 Dec 2023 16:54:18 -0800 (PST)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCMv1DX002263;
	Wed, 13 Dec 2023 00:53:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=lbS2sOhFO9H2/jPqcY5CcYk1fjHyj8RVG0VTiN5eHDE=;
 b=ao/jdpu2hZt3J9owEiX4iHbmvAEUN4JfD/u6ng6C8n9tR+ctw1emwbC0SMYXm/R0Ep2r
 dLil8U64b294FtxyB/9bn2k4LVctv80bqBByC2OMEXLDdkqmYI/Fv7adjHyOwv+T1V/e
 zA0cd4VOeN2iautx0zv9gzrI2ll9ETQXvxWu8dWS+VYITQ7dP/PzeI5lVc+GPC/2esJx
 n7+gu6fyQ7lHDGtv3IxOWMoDv+eiObGE73khBaLn1gFBOHC1iz1QIooOSDa7XwLJyfEU
 wFITkKyW+BZ0Os+RgaD+mzwDe5+J37gIEsvaGHzbfQgB4kd4ifB89QqHDOTvAsgRLBBm Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uy0rv2k3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Dec 2023 00:53:58 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BD0diKk022697;
	Wed, 13 Dec 2023 00:53:57 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uy0rv2k35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Dec 2023 00:53:57 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCN7OsC013874;
	Wed, 13 Dec 2023 00:53:56 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw5924m32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Dec 2023 00:53:55 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BD0rr0214221950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 00:53:53 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 307E92004B;
	Wed, 13 Dec 2023 00:53:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E28A720040;
	Wed, 13 Dec 2023 00:53:51 +0000 (GMT)
Received: from [9.171.70.156] (unknown [9.171.70.156])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Dec 2023 00:53:51 +0000 (GMT)
Message-ID: <679e7142d4ed4da34b6b4b756216170d6c789e84.camel@linux.ibm.com>
Subject: Re: [PATCH v2 18/33] lib/string: Add KMSAN support to strlcpy() and
 strlcat()
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexander Potapenko <glider@google.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton
 <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David
 Rientjes <rientjes@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joonsoo
 Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>,
        Masami
 Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven
 Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>, Vlastimil
 Babka <vbabka@suse.cz>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle
 <svens@linux.ibm.com>
Date: Wed, 13 Dec 2023 01:53:51 +0100
In-Reply-To: <CAG_fn=XQkhecLYFmJugOG+GawvDQ5Xsj5fTRbOAhU8Z5CfsjPA@mail.gmail.com>
References: <20231121220155.1217090-1-iii@linux.ibm.com>
	 <20231121220155.1217090-19-iii@linux.ibm.com>
	 <CAG_fn=XQkhecLYFmJugOG+GawvDQ5Xsj5fTRbOAhU8Z5CfsjPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CoFzpVB1hjayWnb5EoMT-xEl3omYP96D
X-Proofpoint-ORIG-GUID: hDPpadErq5XkPzsxCdCzkDyCXRSYxuts
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_14,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=812
 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130004

On Fri, 2023-12-08 at 17:50 +0100, Alexander Potapenko wrote:
> On Tue, Nov 21, 2023 at 11:02=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.=
com>
> wrote:
> >=20
> > Currently KMSAN does not fully propagate metadata in strlcpy() and
> > strlcat(), because they are built with -ffreestanding and call
> > memcpy(). In this combination memcpy() calls are not instrumented.
>=20
> Is this something specific to s390?

Nice catch - I can't reproduce this behavior anymore. Even if I go
back to the clang version that first introduced KMSAN on s390x, the
memset() instrumentation with -ffreestanding is still there. I should
have written down more detailed notes after investigating this, but
here we are. I will drop this patch as well as 10/33.

[...]

