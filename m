Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C65E412A697
	for <lists+linux-s390@lfdr.de>; Wed, 25 Dec 2019 08:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbfLYHek (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 25 Dec 2019 02:34:40 -0500
Received: from mail01.vodafone.es ([217.130.24.71]:39176 "EHLO
        mail01.vodafone.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfLYHek (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 25 Dec 2019 02:34:40 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Dec 2019 02:34:38 EST
IronPort-SDR: vLeDDbqYtRcBls4h14SAarIwAAjiec7t3RieXTxVEP6QC4Q4ukMmHhokYsxlRYYgLZpv7HFrJq
 7Zqz/NLIDxJA==
IronPort-PHdr: =?us-ascii?q?9a23=3AK0LGUBxvafH1eBDXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2+sXIJqq85mqBkHD//Il1AaPAdyArage0KGI6ujJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVijexe61+IAu4oAnet8QanJZpJ7osxB?=
 =?us-ascii?q?fOvnZGYfldy3lyJVKUkRb858Ow84Bm/i9Npf8v9NNOXLvjcaggQrNWEDopM2?=
 =?us-ascii?q?Yu5M32rhbDVheA5mEdUmoNjBVFBRXO4QzgUZfwtiv6sfd92DWfMMbrQ704RS?=
 =?us-ascii?q?iu4qF2QxLulSwJNSM28HvPh8J+jKxbugyvqR9izYHbfI6bO+Fzfr/fcNwGWW?=
 =?us-ascii?q?ZNQtpdWzJHD4ihb4UPFe0BPeNAoof7vVQFsAGwBROtBOPqyz9Imn723bMg3O?=
 =?us-ascii?q?88FgzGwBEgH9YSv3TVsdr6LrwSXPuwzKbSzDXDa+la2Svj54jMbB8hueuDUq?=
 =?us-ascii?q?5qfcrJ1UkiDgXIhUiTp4z9Jz6ZyPkBvmqB4+Z9W++jl3Qrpx9+rzS1yMohio?=
 =?us-ascii?q?/EjZ8PxF/e7yV22oM1KMW9SE58fNGrDoNdtzqfN4tqWsMiRHxouDoixr0Gp5?=
 =?us-ascii?q?G7eC8KxYwixxHFavyHd5KI7QznVOqNLjp0nmxleLWiiBmo/0igzev8Wdeu3F?=
 =?us-ascii?q?lUtSpJitjMtnYT2BzP8sWLVOZx80W71TqS2Q3f9vtILV47mKbBJZMswqY8lp?=
 =?us-ascii?q?8JvkTCGi/2ll/2jKiTdkg85uio9uDnbannppCBLYB0kRrzMqE0lcy+BeQ0KB?=
 =?us-ascii?q?QOUHaf+euizL3s51H2TK9Sjv0qiqXZqozVJdwHpq6lBA9YyoIj6xe5Dze739?=
 =?us-ascii?q?UUhGIHIVxBdR6blIXpJV7OL+7iDfulgFSjji1rx/bYMb3lGJnNKWLDkLiyNY?=
 =?us-ascii?q?p6vkpdzhcjiMsEtsp8FL4MOrTwV1X3udieCQU2YDa52+L2NNIo8opWYXiOB6?=
 =?us-ascii?q?6FMb3b+QuM7/o1IuyNeI4LsTvmA+oi5/nrhH4931IAK/qHx5wSPVSxVsx8Ik?=
 =?us-ascii?q?CYfXvyi59VDXoOtQsyRffCjVSDVXhPanK/R6s3oCknXtH1RbzfT5yg1eTSlB?=
 =?us-ascii?q?ywGYdbMzhL?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GEKgAaDwNelyMYgtllgkQBGAEBgns?=
 =?us-ascii?q?3GyASk0JUBnUdihKFM4N8FYYaDIFbDQEBAQEBNQIBAYRAgiIkOBMCAw0BAQU?=
 =?us-ascii?q?BAQEBAQUEAQECEAEBAQEBCBYGhXNCAQwBgWsihBeBA4EsgwOCUymtGxoChSO?=
 =?us-ascii?q?Ec4E2AYwYGnmBB4FEgjKFAgESAWyFIQSNRSGIS2GXfoI+BJYwDYIpAYw4A4J?=
 =?us-ascii?q?UiRGnIoI3VYELgQpxTTiBchmBHU8YDY0sji1AgRYQAk+FQIdcgjIBAQ?=
X-IPAS-Result: =?us-ascii?q?A2GEKgAaDwNelyMYgtllgkQBGAEBgns3GyASk0JUBnUdi?=
 =?us-ascii?q?hKFM4N8FYYaDIFbDQEBAQEBNQIBAYRAgiIkOBMCAw0BAQUBAQEBAQUEAQECE?=
 =?us-ascii?q?AEBAQEBCBYGhXNCAQwBgWsihBeBA4EsgwOCUymtGxoChSOEc4E2AYwYGnmBB?=
 =?us-ascii?q?4FEgjKFAgESAWyFIQSNRSGIS2GXfoI+BJYwDYIpAYw4A4JUiRGnIoI3VYELg?=
 =?us-ascii?q?QpxTTiBchmBHU8YDY0sji1AgRYQAk+FQIdcgjIBAQ?=
X-IronPort-AV: E=Sophos;i="5.69,353,1571695200"; 
   d="scan'208";a="298564861"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail01.vodafone.es with ESMTP; 25 Dec 2019 08:29:35 +0100
Received: (qmail 32296 invoked from network); 25 Dec 2019 04:33:52 -0000
Received: from unknown (HELO 192.168.1.88) (seigo@[217.217.179.17])
          (envelope-sender <tulcidas@mail.telepac.pt>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-s390@vger.kernel.org>; 25 Dec 2019 04:33:52 -0000
Date:   Wed, 25 Dec 2019 05:33:43 +0100 (CET)
From:   La Primitiva <tulcidas@mail.telepac.pt>
Reply-To: La Primitiva <laprimitivaes@zohomail.eu>
To:     linux-s390@vger.kernel.org
Message-ID: <27788178.259408.1577248423672.JavaMail.javamailuser@localhost>
Subject: Take home 750,000 Euros this end of year
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Attn: Email User,

You have won, you are to reply back with your name and phone number for
claim.

La Primitiva




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

