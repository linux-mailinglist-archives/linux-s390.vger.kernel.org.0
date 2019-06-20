Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4215930D
	for <lists+linux-s390@lfdr.de>; Fri, 28 Jun 2019 06:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfF1Ex7 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 28 Jun 2019 00:53:59 -0400
Received: from mail-pg1-f232.google.com ([209.85.215.232]:35528 "EHLO
        mail-pg1-f232.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfF1Ex6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 28 Jun 2019 00:53:58 -0400
Received: by mail-pg1-f232.google.com with SMTP id s27so2029222pgl.2
        for <linux-s390@vger.kernel.org>; Thu, 27 Jun 2019 21:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ctcd-edu.20150623.gappssmtp.com; s=20150623;
        h=from:subject:thread-topic:thread-index:date:message-id
         :accept-language:content-language:content-transfer-encoding
         :mime-version;
        bh=uja0RKLj8/ZClYB7/xee4WJU8BS3tEVS8HkeIEY1v6o=;
        b=yoeySuHZ2sejtG818TC1O/sRk49+/vQ3CbN+Cdo+UHW9L5funzQd2Q0pE2uLs0b0US
         3ooTACMRlY79vI4FLzqFZKHKKrxPTrXgXaWMcqe8jgbG9TaDTNtilkTZRtg6VlUGiKdp
         KbTF2mzomGYMgE4bQnu5VDh7bapfFBiT2qYBZJe7YG5LbyDWz/Eh/rPZUG+Ac0xjJxZH
         W3mbIfopUIqlT0EL+QWT7o/xSZm5JFZCL+eCmMMNv60Jnl/aFltkCdOXb5SlSsjXYCQB
         Nb4cLYVjYvOUfUwx9XO2NitclNXqBV9hkxd1YcPbhSzExvM/+lHPAma8+4zL50ilre/p
         2Ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:thread-topic:thread-index:date
         :message-id:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=uja0RKLj8/ZClYB7/xee4WJU8BS3tEVS8HkeIEY1v6o=;
        b=geeMOYEgo8vazReSQw2qXtt7unyuXsa2uWDsbtEucKejh+XIaBNA3rMYbxOnye9JJm
         K4X5qHf7YMTy2MQbeUSINmahgzh9EWCmTvuiFDGOotm/ZFw6/MWrWuSOj0l80AIafOI6
         T5OmzlLLymlaaPWjNrYDbUk/vs7G3WtHnOZmBGAh8XUNVTf0F1YhXbtowkVGV5/48UPI
         7TYCKFRYwUYARaejUd+e5KnkQPEzhZ+FCGNIYOcSak0/wnwUBrbmIAjeDMFIncFQ4njP
         OMeQhcRnB1RFh2+PvDWPzm1EF7CFiEvaGOqJkQDEKQXZSjqd/PVvvgIKBIQtKDLK3wVP
         +tkA==
X-Gm-Message-State: APjAAAW13pVdy2UJbmJooNbiZ8CL/l4HQNPKafBdE9uAJAn37krlfzw8
        BPo7HMbfakg34FY7U1O1p1T74d5C2RGAYM7iB4tbkoClHuJu8g==
X-Google-Smtp-Source: APXvYqxJkYMp/D0/TOWa0cF+M2QrMgL6Fs/241l24lc+p+ZxC69PNEQYyCft/PgXL83TNevq6R0mSpDU13C7
X-Received: by 2002:a17:90a:20c6:: with SMTP id f64mr10700090pjg.57.1561697638054;
        Thu, 27 Jun 2019 21:53:58 -0700 (PDT)
Received: from mail.ctcd.edu (rrcs-67-79-90-89.sw.biz.rr.com. [67.79.90.89])
        by smtp-relay.gmail.com with ESMTPS id n69sm110753pjb.9.2019.06.27.21.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 21:53:58 -0700 (PDT)
X-Relaying-Domain: ctcd.edu
Received: from CTCEmail02.campus.ctcd.org (172.17.139.89) by
 CTCEmail01.campus.ctcd.org (172.17.139.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.845.34; Thu, 20 Jun 2019 09:20:21 -0500
Received: from CTCEmail02.campus.ctcd.org ([fe80::a0bb:ad1f:8c21:8800]) by
 CTCEmail02.campus.ctcd.org ([fe80::a0bb:ad1f:8c21:8800%2]) with mapi id
 15.01.0845.034; Thu, 20 Jun 2019 09:20:21 -0500
From:   "Chambers, Marcine" <MChambers@ctcd.edu>
Subject: GOOD DAY
Thread-Topic: GOOD DAY
Thread-Index: AQHVJ3NH8MyJd8SpTkSfWerfM/UxGQ==
Date:   Thu, 20 Jun 2019 14:20:21 +0000
Message-ID: <1bcebb25cbc54329a424613008b7d525@ctcd.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.139.254]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

I am Vice Chairman of Hang Seng Bank, I have Important Matter to Discuss wi=
th you concerning my late client, Died without a NEXT OF KIN. Send me your =
private email for full details information. email me at (chienkraymond@outl=
ook.com)

Mail:infocarfer@aim.com

Regards
Dr.Raymond Chien Kuo Fung

